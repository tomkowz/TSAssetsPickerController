//
//  TSFilterDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsFilter;
@class TSAssetsFilterDimensionsDescriptor;

typedef enum {
    FilterTypePhoto,
    FilterTypeVideo,
    FilterTypeAll
} FilterType;

@interface TSAssetsFilterDescriptor : NSObject
+ (instancetype)filterWithType:(FilterType)type dimensionsDescriptor:(TSAssetsFilterDimensionsDescriptor *)descriptor;

- (BOOL)isSizeMatchToDimensionFilters:(CGSize)size;

@end

@interface TSAssetsFilterDescriptor (AssetsLibrary)
@property (nonatomic, readonly) ALAssetsFilter *assetsFilter;
@end
