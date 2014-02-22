//
//  AssetCell+Confiugration.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetCell+Configuration.h"

@implementation AssetCell (Configuration)

static CGSize _preferedCellSize;
+ (void)setPreferedCellSize:(CGSize)size {
    _preferedCellSize = size;
}

+ (CGSize)preferedCellSize {
    return _preferedCellSize;
}

static CGRect _preferedThumbnailRect;
+ (void)setPreferedThumbnailRect:(CGRect)rect {
    _preferedThumbnailRect = rect;
}

+ (CGRect)preferedThumbnailRect {
    return _preferedThumbnailRect;
}

static CGRect _preferedMovieMarkRect;
+ (void)setPreferedMovieMarkRect:(CGRect)rect {
    _preferedMovieMarkRect = rect;
}

+ (CGRect)preferedMovieMarkRect {
    return _preferedMovieMarkRect;
}

static UIImage *_preferedMovieMarkImage;
+ (void)setPreferedImageForMovieMark:(UIImage *)image {
    _preferedMovieMarkImage = image;
}

+ (UIImage *)preferedMovieMarkImage {
    return _preferedMovieMarkImage;
}

static UIColor *_preferedNormalBackgroundColor;
static UIColor *_preferedSelectedBackgroundColor;
+ (void)setPreferedBackgroundColor:(UIColor *)color forState:(SelectionState)controlState {
    switch (controlState) {
        case Normal:
            _preferedNormalBackgroundColor = color;
            break;
            
        case Selected:
            _preferedSelectedBackgroundColor = color;
    }
}

+ (UIColor *)preferedBackgroundColorForState:(SelectionState)controlState {
    UIColor *color;
    switch (controlState) {
        case Normal:
            color = _preferedNormalBackgroundColor;
            break;
            
        case Selected:
            color = _preferedSelectedBackgroundColor;
    }
    return color;
}

@end