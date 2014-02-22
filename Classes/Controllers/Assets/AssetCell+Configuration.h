//
//  AssetCell+Confiugration.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetCell.h"

typedef enum {
    Normal,
    Selected
} SelectionState;

@interface AssetCell (Configuration)

+ (CGSize)preferedCellSize;
+ (void)setPreferedCellSize:(CGSize)size;

+ (CGRect)preferedThumbnailRect;
+ (void)setPreferedThumbnailRect:(CGRect)rect;

+ (CGRect)preferedMovieMarkRect;
+ (void)setPreferedMovieMarkRect:(CGRect)rect;

+ (UIImage *)preferedMovieMarkImage;
+ (void)setPreferedImageForMovieMark:(UIImage *)image;

+ (UIColor *)preferedBackgroundColorForState:(SelectionState)controlState;
+ (void)setPreferedBackgroundColor:(UIColor *)color forState:(SelectionState)controlState;

@end
