//
//  TSFilterDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsFilterDescriptor.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "TSAssetsFilterDimensionsDescriptor.h"

@interface TSAssetsFilterDescriptor ()
@property (nonatomic) FilterType filterType;
@property (nonatomic) TSAssetsFilterDimensionsDescriptor *descriptor;
@end

@implementation TSAssetsFilterDescriptor

+ (instancetype)filterWithType:(FilterType)type dimensionsDescriptor:(TSAssetsFilterDimensionsDescriptor *)descriptor {
    return [[self alloc] initWithType:type dimensionsDescriptor:descriptor];
}

- (instancetype)initWithType:(FilterType)type dimensionsDescriptor:(TSAssetsFilterDimensionsDescriptor *)descriptor {
    self = [super init];
    if (self) {
        _filterType = type;
        _descriptor = descriptor;
    }
    return self;
}

- (BOOL)isSizeMatchToDimensionFilters:(CGSize)size {
    return [_descriptor isSizeMatchToFilter:size];
}

@end

@implementation TSAssetsFilterDescriptor (AssetsLibrary)

- (ALAssetsFilter *)assetsFilter {
    ALAssetsFilter *filter = nil;
    switch (_filterType) {
        case FilterTypePhoto:
            filter = [ALAssetsFilter allPhotos];
            break;
            
        case FilterTypeVideo:
            filter = [ALAssetsFilter allVideos];
            break;
            
        case FilterTypeAll:
            filter = [ALAssetsFilter allAssets];
            break;
    }
    
    return filter;
}

@end