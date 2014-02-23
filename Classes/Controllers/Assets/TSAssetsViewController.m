//
//  TSAssetsViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsViewController.h"

#import "AssetCell.h"
#import "SystemVersionMacros.h"
#import "TSAssetsLoader.h"
#import "TSAssetsManager.h"
#import "TSAssetsPickerController.h"
#import "AssetsFlowLayout.h"
#import "AssetsCollectionView.h"

@interface TSAssetsViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    TSAssetsManager *_assetsManager;
    NSIndexPath *_selectedIndexPath;
    NSString *_albumName;
}

@end

@implementation TSAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupAssetsManager];

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
    TSAssetsLoader *assetsLoader =
    [[TSAssetsLoader alloc] initWithLibrary:[ALAssetsLibrary new]
                                     filter:_picker.filter];
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
    [_delegate assetsViewController:self didFinishPickingAssets:_assetsManager.selectedAssets];
}


#pragma mark - Fetch
- (void)_fetchAssets {
    [_assetsManager fetchAssetsWithAlbumName:_albumName block:^(NSUInteger numberOfAssets, NSError *error) {
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
    cellIdentifier = NSStringFromClass(_picker.subclassOfAssetCellClass);
    
    CGRect frame = self.view.bounds;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        frame.size.height -= CGRectGetHeight(self.navigationController.navigationBar.frame);
    }

    CGSize cellSize = [_picker.subclassOfAssetCellClass preferedCellSize];
    UICollectionViewFlowLayout *layout = [[_picker.subclassOfAssetsFlowLayoutClass alloc] initWithItemSize:cellSize];
    // workaround, I don't know why collection view not call this properties itself.
    layout.sectionInset = layout.sectionInset;
    layout.scrollDirection = layout.scrollDirection;
    layout.minimumLineSpacing = layout.minimumLineSpacing;
    layout.minimumInteritemSpacing = layout.minimumInteritemSpacing;
    
    UICollectionView *collectionView = [[_picker.subclassOfAssetsCollectionViewClass alloc] initWithFrame:frame collectionViewLayout:layout];
    [collectionView registerClass:_picker.subclassOfAssetCellClass forCellWithReuseIdentifier:cellIdentifier];
    
    BOOL scrollVertical = (layout.scrollDirection == UICollectionViewScrollDirectionVertical);
    [collectionView setAlwaysBounceVertical:scrollVertical];
    [collectionView setAlwaysBounceHorizontal:!scrollVertical];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    return collectionView;
}

- (UIBarButtonItem *)newSelectButton {
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleDone target:self action:@selector(onSelectPressed)];
    [selectButton setEnabled:NO];
    return selectButton;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assetsManager.fetchedAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        Class class = _picker.subclassOfAlbumCellClass;
        cell = [class new];
    }

    ALAsset *asset = _assetsManager.fetchedAssets[indexPath.row];
    BOOL isSelected = [_assetsManager isAssetSelected:asset];
    
    [cell configure:asset];
    [cell markAsSelected:isSelected];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL shouldSelect = (_assetsManager.selectedAssets.count < _picker.numberOfItemsToSelect);

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
        [cell setBackgroundColor:[UIColor blueColor]];
    }
    
    [cell markAsSelected:shouldSelect];
    [_selectButton setEnabled:(_assetsManager.selectedAssets.count > 0)];
    
    return shouldSelect;
}


@end
