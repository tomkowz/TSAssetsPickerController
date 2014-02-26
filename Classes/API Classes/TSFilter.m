//
//  TSFilterDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSFilter.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "TSDescriptor.h"

@interface TSFilter ()
@property (nonatomic) FilterType filterType;
@property (nonatomic) TSDescriptor *descriptor;
@end

@implementation TSFilter

+ (instancetype)filterWithType:(FilterType)type descriptor:(TSDescriptor *)descriptor {
    return [[self alloc] initWithType:type descriptor:descriptor];
}

- (instancetype)initWithType:(FilterType)type descriptor:(TSDescriptor *)descriptor {
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

@implementation TSFilter (AssetsLibrary)

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