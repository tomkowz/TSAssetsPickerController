//
//  TSFilterDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsFilter;

typedef enum {
    FilterTypePhoto,
    FilterTypeVideo,
    FilterTypeAll
} FilterType;

@interface TSAssetsFilterDescriptor : NSObject
@property (nonatomic) FilterType filterType;
@property (nonatomic) NSArray *dimensionFilters;
@end

@interface TSAssetsFilterDescriptor (AssetsLibrary)
@property (nonatomic, readonly) ALAssetsFilter *assetsFilter;
@end
