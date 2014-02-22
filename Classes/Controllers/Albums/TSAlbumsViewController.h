//
//  TSAlbumsViewController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSAlbumsViewControllerDelegate;

@interface TSAlbumsViewController : UIViewController
@property (nonatomic) UITableView *tableView;
@property (nonatomic, weak) id <TSAlbumsViewControllerDelegate> delegate;
@end

@protocol TSAlbumsViewControllerDelegate <NSObject>
- (void)albumsViewControllerDidCancel:(TSAlbumsViewController *)albumsVC;
@end