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
@property (nonatomic) UIImageView *thumbnailImageView;
@property (nonatomic) UIImageView *movieMarkImageView;

@property (nonatomic, readonly, getter = isCellSelected) BOOL cellSelected;

- (void)configure:(ALAsset *)asset;
- (void)markAsSelected:(BOOL)selected;

#pragma mark - Customization
+(CGSize) preferedCellSize;
+(CGRect) preferedThumbnailRect;
+(CGRect) preferedMovieMarkRect;
+(UIImage *) preferedMovieMarkImage;
+(UIColor *) preferedBackgroundColorForStateNormal;
+(UIColor *) preferedBackgroundColorForStateSelected;

@end
