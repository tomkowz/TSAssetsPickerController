//
//  TSFilterDimensionsDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSSizePredicate.h"

#import "TSSizeComparator.h"

@implementation TSSizePredicate {
    NSArray *_dimensions;
    EqualityType _equalityType;
}

+ (instancetype)matchSizes:(NSArray *)sizes {
    return [[self alloc] initWithDimensions:sizes type:EqualityTypeEqual];
}

+ (instancetype)matchSize:(CGSize)size {
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:EqualityTypeEqual];
}

+ (instancetype)matchSizeLessThan:(CGSize)size orEqual:(BOOL)equal {
    EqualityType type = equal ? EqualityTypeLessThanOrEqual : EqualityTypeLessThan;
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:type];
}

+ (instancetype)matchSizeGreaterThan:(CGSize)size orEqual:(BOOL)equal {
    EqualityType type = equal ? EqualityTypeGreaterThanOrEqual : EqualityTypeGreaterThan;
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:type];
}


+ (instancetype)predicateWithDimensions:(NSArray *)dimensions type:(EqualityType)type {
    return [[self alloc] initWithDimensions:dimensions type:type];
}

- (instancetype)initWithDimensions:(NSArray *)dimensions type:(EqualityType)type {
    self = [super init];
    if (self) {
        _dimensions = dimensions;
        _equalityType = type;
    }
    return self;
}

- (BOOL)isSizeMatch:(CGSize)size {
    BOOL result = NO;
    for (NSValue *value in _dimensions) {
        CGSize sizeValue = [value CGSizeValue];
        BOOL compareResult = [TSSizeComparator compareSize:size toSize:sizeValue withEquality:_equalityType];
        if (compareResult) {
            result = YES;
            break;
        }
    }
    
    return result;
}

@end
