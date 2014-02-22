//
//  AssetCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation AssetCell
@synthesize cellSelected = _cellSelected;

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _cellSelected = NO;
}


#pragma mark - Configuration
- (void)configure:(ALAsset *)asset {
    CGImageRef thumbnailRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailRef];
    [_assetThumbnail setImage:thumbnail];
    
    NSString *type = [asset valueForProperty:ALAssetPropertyType];
    [_movieMark setHidden:(![type isEqualToString:ALAssetTypeVideo])];
}


#pragma mark - Modificators
- (void)markAsSelected:(BOOL)selected {
    _cellSelected = selected;

    UIColor *color;
    if (selected ) {
        color = [UIColor colorWithRed:21.0f/255.0f green:150.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    } else {
        color = [UIColor colorWithWhite:0.7 alpha:0.3];
    }
    
    [self setBackgroundColor:color];
    [_movieMark setBackgroundColor:color];
}

@end
