//
//  TSAssetsViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsViewController.h"

#import "AssetCell.h"
#import "AlbumCell.h"
#import "AssetsCollectionView.h"
#import "SystemVersionMacros.h"
#import "TSAssetsLoader.h"
#import "TSAssetsManager.h"
#import "TSAssetsPickerController.h"
#import "TSAssetsPickerController+Internals.h"
#import "AssetsCollectionViewLayout.h"

@interface TSAssetsViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    TSAssetsManager *_assetsManager;
    NSIndexPath *_selectedIndexPath;
    NSString *_albumName;

    NSOperationQueue *_thumbnailQueue;
    
    UIActivityIndicatorView *_indicatorView;
    UIBarButtonItem *_selectBarButtonItem;
}

@end

@implementation TSAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupAssetsManager];
    
    _thumbnailQueue = [NSOperationQueue new];
    _thumbnailQueue.maxConcurrentOperationCount = 3;
    
    [self _setupViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_fetchAssets)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)_setupViews {
    _collectionView = [self newCollectionView];

    [self.view addSubview:_collectionView];
    
    _selectButton = [self newSelectButton];
    self.navigationItem.rightBarButtonItem = _selectButton;
}

- (void)_setupAssetsManager {
    TSFilter *filter = [_picker.dataSource filterOfAssetsPickerController:_picker];

    TSAssetsLoader *assetsLoader =
    [[TSAssetsLoader alloc] initWithLibrary:[ALAssetsLibrary new]
                                     filter:filter];
    assetsLoader.shouldReverseOrder = _picker.shouldReverseAssetsOrder;
    
    _assetsManager = [TSAssetsManager managerWithLoader:assetsLoader];
}

- (void)configureWithAlbumName:(NSString *)name {
    _albumName = name;
    self.navigationItem.title = name;
    [_assetsManager deselectAllAssets];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _fetchAssets];
}


#pragma mark - Actions
- (void)onSelectPressed {
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.collectionView.userInteractionEnabled = NO;
    
    [self _addActivityIndicatorToNavigationBar];
    
    [_delegate assetsViewController:self didFinishPickingAssets:_assetsManager.selectedAssets];
}

- (void)_addActivityIndicatorToNavigationBar {
    if (!_indicatorView) {
        _indicatorView = [_picker activityIndicatorViewForPlaceIn:AssetsView];
    }
    
    _selectBarButtonItem = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *itemIndicator = [[UIBarButtonItem alloc] initWithCustomView:_indicatorView];
    [self.navigationItem setRightBarButtonItem:itemIndicator];
    [_indicatorView startAnimating];
}

- (void)_removeActivityIndicatorFromNavigationBar {
    [_indicatorView stopAnimating];
    [self.navigationItem setRightBarButtonItem:_selectBarButtonItem];
}


#pragma mark - Fetch
- (void)_fetchAssets {
    [self _addActivityIndicatorToNavigationBar];
    [_assetsManager fetchAssetsWithAlbumName:_albumName block:^(NSUInteger numberOfAssets, NSError *error) {
        [self _removeActivityIndicatorFromNavigationBar];
        if (!error) {
            if (numberOfAssets > 0 || _picker.shouldShowEmptyAlbums)
                [_collectionView reloadData];
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            [_delegate assetsViewController:self failedWithError:error];
        }
    }];
}


#pragma mark - Setup View
static NSString *cellIdentifier = nil;
- (UICollectionView *)newCollectionView {
    Class subclassOfAssetCellClass = [_picker subclassForClass:[AssetCell class]];
    cellIdentifier = NSStringFromClass(subclassOfAssetCellClass);

    CGRect frame = self.view.bounds;
    
    Class collectionViewClass = [_picker subclassForClass:[AssetsCollectionView class]];
    
    UICollectionViewLayout *layout = [_picker assetsCollectionViewLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
    UICollectionView *collectionView =
    [[collectionViewClass alloc] initWithFrame:frame
                          collectionViewLayout:layout];
    
    [collectionView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth |
                                         UIViewAutoresizingFlexibleHeight)];

    [collectionView registerClass:subclassOfAssetCellClass
       forCellWithReuseIdentifier:cellIdentifier];

    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    
    return collectionView;
}

- (UIBarButtonItem *)newSelectButton {
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc] initWithTitle:_picker.selectButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(onSelectPressed)];
    [selectButton setEnabled:NO];
    return selectButton;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assetsManager.fetchedAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        Class class = [_picker subclassForClass:[AlbumCell class]];
        cell = [class new];
    }

    ALAsset *asset = _assetsManager.fetchedAssets[indexPath.row];
    
    [cell configure:asset];

    BOOL isSelected = [_assetsManager isAssetSelected:asset];
    [cell markAsSelected:isSelected];

    __weak TSAssetsViewController *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        CGImageRef thumbnailRef = [asset thumbnail];
        UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailRef];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                id aCell = [weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                [[(AssetCell *)aCell thumbnailImageView] setImage:thumbnail];
                NSString *type = [asset valueForProperty:ALAssetPropertyType];
                [[(AssetCell *)aCell movieMarkImageView] setHidden:(![type isEqualToString:ALAssetTypeVideo])];
            }
        });
    }];
    
    [_thumbnailQueue addOperation:operation];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL shouldSelect = (_assetsManager.selectedAssets.count < [_picker.dataSource numberOfItemsToSelectInAssetsPickerController:_picker]);

    AssetCell *cell = (AssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isCellSelected) {
        shouldSelect = NO;
    }
    
    ALAsset *asset = _assetsManager.fetchedAssets[indexPath.row];
    if (shouldSelect) {
        [_assetsManager selectAsset:asset];
        _selectedIndexPath = indexPath;
    } else {
        [_assetsManager deselectAsset:asset];
    }
    
    [cell markAsSelected:shouldSelect];
    [_selectButton setEnabled:(_assetsManager.selectedAssets.count > 0)];
    
    return shouldSelect;
}

#pragma mark - View Rotation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    _collectionView.collectionViewLayout = [_picker assetsCollectionViewLayoutForOrientation:toInterfaceOrientation];
    [_collectionView reloadData];
}

@end
