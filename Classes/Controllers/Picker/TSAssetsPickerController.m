//
//  TSAssetsPickerController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController.h"

#import "TSAlbumsViewController.h"

@interface TSAssetsPickerController () < TSAlbumsViewControllerDelegate> {
    TSAlbumsViewController *_albumsVC;
}
@end

@implementation TSAssetsPickerController

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _configureAlbumsViewController];
}

- (void)_setup {
    _numberOfItemsToSelect = 1;
    _filter = [ALAssetsFilter allPhotos];
    _noAlbumsForSelectedFilter = @"No albums for selected filter";
    _shouldReverseAlbumsOrder = YES;
    _shouldReverseAssetsOrder = YES;
    _shouldShowEmptyAlbums = NO;
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
//    [self performSelector:@selector(popToRootViewControllerAnimated:) withObject:@(NO) afterDelay:0.1];
    [self.delegate assetsPickerController:self didFinishPickingAssets:assets];
}

- (void)albumsViewController:(TSAlbumsViewController *)albumsVC failedWithError:(NSError *)error {
//    [self performSelector:@selector(popToRootViewControllerAnimated:) withObject:@(NO) afterDelay:0.1];
    [self.delegate assetsPickerController:self failedWithError:error];
}

@end
