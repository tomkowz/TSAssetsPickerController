//
//  TSAssetsPickerController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController.h"
#import "TSAssetsPickerController+Internals.h"

#import "AlbumCell.h"
#import "AssetCell.h"
#import "TSAlbumsViewController.h"
#import "NoAlbumsCell.h"
#import "AssetsCollectionView.h"
#import "AlbumsTableView.h"

@interface TSAssetsPickerController () < TSAlbumsViewControllerDelegate> {
    TSAlbumsViewController *_albumsVC;
}

@end

@implementation TSAssetsPickerController

- (void)checkDataSource {    
    if (![self.dataSource respondsToSelector:@selector(numberOfItemsToSelectInAssetsPickerController:)])
        [NSException raise:@"TSAssetsPickerController" format:@"dataSource must responds to numberOfItemsToSelectInAssetsPickerController:"];
    
    if (![self.dataSource respondsToSelector:@selector(filterOfAssetsPickerController:)])
        [NSException raise:@"TSAssetsPickerController" format:@"dataSource must responds to filterOfAssetsPickerController:"];
}

- (void)viewDidLoad
{
    [self checkDataSource];
    [super viewDidLoad];
    [self _configureAlbumsViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_albumsVC) {
        [self _configureAlbumsViewController];
    }
    
    if (!_albumsVC.isViewLoaded && !_albumsVC.view.window) {
        [self pushViewController:_albumsVC animated:NO];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self popToRootViewControllerAnimated:NO];
    [_albumsVC removeFromParentViewController];
    _albumsVC = nil;
}

- (void)_configureAlbumsViewController {
    _albumsVC = [TSAlbumsViewController new];
    _albumsVC.delegate = self;
    _albumsVC.picker = self;
}


#pragma mark - TSAlbumsViewControllerDelegate
- (void)albumsViewControllerDidCancel:(TSAlbumsViewController *)albumsVC {
    [self.delegate assetsPickerControllerDidCancel:self];
}

- (void)albumsViewController:(TSAlbumsViewController *)albumsVC didFinishPickingAssets:(NSArray *)assets {
    [self.delegate assetsPickerController:self didFinishPickingAssets:assets];
}

- (void)albumsViewController:(TSAlbumsViewController *)albumsVC failedWithError:(NSError *)error {
    [self.delegate assetsPickerController:self failedWithError:error];
}

@end
