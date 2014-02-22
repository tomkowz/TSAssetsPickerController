//
//  TSAssetsPickerController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@protocol TSAssetsPickerControllerDelegate;

@interface TSAssetsPickerController : UINavigationController
@property (nonatomic, weak) id <TSAssetsPickerControllerDelegate, UINavigationControllerDelegate> delegate;
@end

@protocol TSAssetsPickerControllerDelegate <NSObject>
- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets library:(ALAssetsLibrary *)library;
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker;
@end