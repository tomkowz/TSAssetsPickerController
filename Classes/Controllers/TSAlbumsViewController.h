//
//  TSAlbumsViewController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSAssetsPickerController;

@protocol TSAlbumsViewControllerDelegate;

@interface TSAlbumsViewController : UIViewController
@property (nonatomic) UITableView *tableView;
@property (nonatomic, weak) id <TSAlbumsViewControllerDelegate> delegate;
@property (nonatomic, weak) TSAssetsPickerController *picker;
@end

@protocol TSAlbumsViewControllerDelegate <NSObject>
- (void)albumsViewController:(TSAlbumsViewController *)albumsVC didFinishPickingAssets:(NSArray *)assets;
- (void)albumsViewControllerDidCancel:(TSAlbumsViewController *)albumsVC;
- (void)albumsViewController:(TSAlbumsViewController *)albumsVC failedWithError:(NSError *)error;

@end