//
//  AssetsCollectionViewLayout.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 01.03.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat internItemSpacingY;
@property (nonatomic) NSUInteger numberOfColumns;

@end
