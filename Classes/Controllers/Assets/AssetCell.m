//
//  AssetCell.m
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation AssetCell {
    UIImageView *_movieIconImageView;
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
    static CGRect imageViewRect;
    if (CGRectEqualToRect(imageViewRect, CGRectZero)) {
        imageViewRect = CGRectInset(self.bounds, 4, 4); // border
    }
    
    CGImageRef thumbnailRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailRef];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
    [imageView setImage:thumbnail];
    
    [self.contentView addSubview:imageView];
    
    // type
    NSString *type = [asset valueForProperty:ALAssetPropertyType];
    if ([type isEqualToString:ALAssetTypeVideo]) {
        UIImage *movieIcon = [UIImage imageNamed:@"movie"];
        _movieIconImageView = [[UIImageView alloc] initWithImage:movieIcon];
        CGRect frame = _movieIconImageView.frame;
        frame.origin = CGPointMake(CGRectGetMaxX(imageViewRect) - movieIcon.size.width - 2,
                                   CGRectGetMaxY(imageViewRect) - movieIcon.size.height - 2);
        _movieIconImageView.frame = frame;
        [self.contentView addSubview:_movieIconImageView];
    }
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
    [_movieIconImageView setBackgroundColor:color];
}

@end
