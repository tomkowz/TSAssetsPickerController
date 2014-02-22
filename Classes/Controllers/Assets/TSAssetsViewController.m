//
//  TSAssetsViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsViewController.h"

#import "AssetCell.h"
#import "TSAssetsLoader.h"
#import "TSAssetsManager.h"
#import "DummyAssetsImporter.h"

const NSString *DidEndImportAssetsNotification = @"didEndImportAssetsNotification";

const NSUInteger static availableNumberOfSelectedItems = 5;

@interface TSAssetsViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    TSAssetsManager *_assetsManager;
    NSIndexPath *_selectedIndexPath;
    NSString *_albumName;
}

@end

@implementation TSAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fetchAssets)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [self setupAssetsManager];
}

- (void)setupViews {
    _collectionView = [self newCollectionView];
    [self.view addSubview:_collectionView];
    
    _selectButton = [self newSelectButton];
    self.navigationItem.rightBarButtonItem = _selectButton;
}

- (void)setupAssetsManager {
    TSAssetsLoader *assetsLoader =
    [[TSAssetsLoader alloc] initWithLibrary:[ALAssetsLibrary new]
                                     filter:[ALAssetsFilter allAssets]];
    _assetsManager = [TSAssetsManager managerWithLoader:assetsLoader];
    //    _assetsManager.shouldReverseOrder = NO;
}

- (void)configureWithAlbumName:(NSString *)name {
    _albumName = name;
    self.navigationItem.title = name;
}

- (void)onSelectPressed {
    /*
     Do something here with _assetsManager.selectedAssets.
     After all post notification DidEndImportAssetsNotification to dismiss this picker
     
     Here e.g. is called DummyAssetsImporter which can get data from all assets.
     */
    [DummyAssetsImporter importAssets:_assetsManager.selectedAssets];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)DidEndImportAssetsNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchAssets];
}

- (void)fetchAssets {
    [_assetsManager fetchAssetsWithAlbumName:_albumName block:^(NSUInteger numberOfAssets, NSError *error) {
        if (!error) {
            if (numberOfAssets > 0)
                [_collectionView reloadData];
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            NSLog(@"No access to Camera Roll.");
        }
    }];
}


#pragma mark - Setup View
- (UICollectionViewFlowLayout *)newCollectionViewLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(74, 74)];
    [layout setMinimumLineSpacing:4.0];
    [layout setMinimumInteritemSpacing:0.0];
    
    return layout;
}

static NSString *cellIdentifier = nil;
- (UICollectionView *)newCollectionView {
    cellIdentifier = NSStringFromClass([AssetCell class]);
    
    CGRect frame = CGRectMake(0, 0,
                              CGRectGetWidth(self.view.frame),
                              CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame));
    
    UICollectionViewFlowLayout *layout = [self newCollectionViewLayout];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [collectionView setContentInset:UIEdgeInsetsMake(4, 4, 0, 4)];
    [collectionView setBounces:YES];
    [collectionView setScrollEnabled:YES];
    
    UINib *cellNib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
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
    AssetCell *cell = (AssetCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (AssetCell *)[topLevelObjects objectAtIndex:0];
    }

    ALAsset *asset = _assetsManager.fetchedAssets[indexPath.row];
    BOOL isSelected = [_assetsManager isAssetSelected:asset];
    
    [cell configure:asset];
    [cell markAsSelected:isSelected];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL shouldSelect = (_assetsManager.selectedAssets.count < availableNumberOfSelectedItems);

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
