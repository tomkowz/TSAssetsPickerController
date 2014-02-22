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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _configureAlbumsViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_albumsVC.isViewLoaded && !_albumsVC.view.window) {
        [self pushViewController:_albumsVC animated:NO];
    }
}

- (void)_configureAlbumsViewController {
    _albumsVC = [TSAlbumsViewController new];
    _albumsVC.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TSAlbumsViewControllerDelegate
- (void)albumsViewControllerDidCancel:(TSAlbumsViewController *)albumsVC {
    [self.delegate assetsPickerControllerDidCancel:self];
}

@end
