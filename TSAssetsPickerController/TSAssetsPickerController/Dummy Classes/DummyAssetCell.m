//
//  DummyAssetCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyAssetCell.h"

@implementation DummyAssetCell

+ (CGSize)preferedCellSize {
    return CGSizeMake(50, 50);
}

+ (CGRect)preferedThumbnailRect {
    return CGRectMake(5, 5, 40, 40);
}

+ (CGRect)preferedMovieMarkRect {
    return CGRectMake(22, 22, 20, 20);
}

+ (UIImage *)preferedMovieMarkImage {
    return [UIImage imageNamed:@"movieMark"];
}

+ (UIColor *)preferedBackgroundColorForStateNormal {
    return [UIColor colorWithWhite:0.4 alpha:0.3];
}

+ (UIColor *)preferedBackgroundColorForStateSelected {
    return [UIColor colorWithRed:100.0f/255.0f green:30.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
}

@end
