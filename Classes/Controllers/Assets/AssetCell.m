//
//  AssetCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "AssetCell+Configuration.h"

@implementation AssetCell {
    UIImageView *_thumbnailImageView;
    UIImageView *_movieMarkImageView;
}

@synthesize cellSelected = _cellSelected;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _cellSelected = NO;
    
    [self setupView];
    [self setupThumbnailImageView];
    [self setupMovieMarkImageView];
}

- (void)setupView {
    CGRect frame = CGRectZero;
    frame.size = [AssetCell preferedCellSize];
    self.frame = frame;
}

- (void)setupThumbnailImageView {
    _thumbnailImageView = [[UIImageView alloc] initWithFrame:[AssetCell preferedThumbnailRect]];
    [self addSubview:_thumbnailImageView];
}

- (void)setupMovieMarkImageView {
    _movieMarkImageView = [[UIImageView alloc] initWithFrame:[AssetCell preferedMovieMarkRect]];
    [_movieMarkImageView setImage:[AssetCell preferedMovieMarkImage]];
    [self addSubview:_movieMarkImageView];
}


#pragma mark - Configuration
- (void)configure:(ALAsset *)asset {
    CGImageRef thumbnailRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailRef];
    [_thumbnailImageView setImage:thumbnail];
    
    NSString *type = [asset valueForProperty:ALAssetPropertyType];
    [_movieMarkImageView setHidden:(![type isEqualToString:ALAssetTypeVideo])];
}


#pragma mark - Modificators
- (void)markAsSelected:(BOOL)selected {
    _cellSelected = selected;

    UIColor *color;
    if (selected ) {
        color = [AssetCell preferedBackgroundColorForState:Selected];
    } else {
        color = [AssetCell preferedBackgroundColorForState:Normal];
    }
    
    [self setBackgroundColor:color];
    [_movieMarkImageView setBackgroundColor:color];
}

@end

