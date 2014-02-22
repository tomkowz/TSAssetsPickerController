//
//  TSAssetsViewController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *DidEndImportAssetsNotification;

@interface TSAssetsViewController : UIViewController
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIBarButtonItem *selectButton;

- (void)configureWithAlbumName:(NSString *)name;

@end
