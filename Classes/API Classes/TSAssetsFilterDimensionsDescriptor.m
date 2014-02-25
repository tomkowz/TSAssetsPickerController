//
//  TSFilterDimensionsDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsFilterDimensionsDescriptor.h"

@implementation TSAssetsFilterDimensionsDescriptor

+ (instancetype)filterWithDimensions:(CGSize)dimensions type:(EqualityType)type {
    return [[self alloc] initWithDimensions:dimensions type:type];
}

- (instancetype)initWithDimensions:(CGSize)dimensions type:(EqualityType)type {
    self = [super init];
    if (self) {
        _dimensions = dimensions;
        _equalityType = type;
    }
    return self;
}

@end
