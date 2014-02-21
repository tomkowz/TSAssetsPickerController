//
//  TSAssetsViewController.m
//  TSAssetPickerController
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
    [self prepareUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fetchAssets)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    TSAssetsLoader *assetsLoader =
    [[TSAssetsLoader alloc] initWithLibrary:[ALAssetsLibrary new]
                                     filter:[ALAssetsFilter allAssets]];
    _assetsManager = [TSAssetsManager managerWithLoader:assetsLoader];
}

- (void)prepareUI {
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_doneButton setEnabled:NO];
    [_doneButton setTitle:@"Import"];
}

- (void)configureWithAlbumName:(NSString *)name {
    _albumName = name;
    self.navigationItem.title = name;
}

static NSString *const kToFrameSettingsSegue = @"ToFrameSettings";
- (IBAction)onSelectPressed:(id)sender {
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
    [_assetsManager fetchAssetsWithAlbumName:_albumName block:^(NSUInteger numberOfAssets) {
        if (numberOfAssets > 0)
            [_collectionView reloadData];
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assetsManager.fetchedAssets.count;
}

static NSString *cellIdentifier = nil;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    cellIdentifier = NSStringFromClass([AssetCell class]);
    AssetCell *assetCell = (AssetCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ALAsset *asset = _assetsManager.fetchedAssets.reverseObjectEnumerator.allObjects[indexPath.row];

    BOOL isSelected = [_assetsManager isAssetSelected:asset];
    
    [assetCell configure:asset];
    [assetCell markAsSelected:isSelected];
    return assetCell;
}


#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL shouldSelect = (_assetsManager.selectedAssets.count < availableNumberOfSelectedItems);

    AssetCell *photoCell = (AssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (photoCell.isCellSelected) {
        shouldSelect = NO;
    }
    
    ALAsset *asset = _assetsManager.fetchedAssets.reverseObjectEnumerator.allObjects[indexPath.row];
    if (shouldSelect) {
        [_assetsManager selectAsset:asset];
        _selectedIndexPath = indexPath;
    } else {
        [_assetsManager deselectAsset:asset];
        [photoCell setBackgroundColor:[UIColor blueColor]];
    }
    
    [photoCell markAsSelected:shouldSelect];
    [_doneButton setEnabled:(_assetsManager.selectedAssets.count > 0)];
    
    return shouldSelect;
}

@end
