//
//  AssetsFlowLayout.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 23.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithItemSize:(CGSize)size;

- (UICollectionViewScrollDirection)scrollDirection;
- (CGFloat)minimumLineSpacing;
- (CGFloat)minimumInteritemSpacing;
- (UIEdgeInsets)sectionInset;

/**
 Don't override -itemSize. TSAssetsPickerController use designed initializer 
 to fill this property with value [AssetCell preferedCellSize].
 */
//- (CGSize)itemSize;

@end
