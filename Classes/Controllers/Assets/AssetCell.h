//
//  AssetCell.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;

@interface AssetCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView *assetThumbnail;
@property (nonatomic, weak) IBOutlet UIImageView *movieMark;

@property (nonatomic, readonly, getter = isCellSelected) BOOL cellSelected;

- (void)configure:(ALAsset *)asset;
- (void)markAsSelected:(BOOL)selected;

@end
