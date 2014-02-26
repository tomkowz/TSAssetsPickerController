//
//  TSFilterDimensionsDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSDescriptor.h"

#import "TSSizeComparator.h"

@implementation TSDescriptor {
    NSArray *_dimensions;
    EqualityType _equalityType;
}

+ (instancetype)descriptorWithDimensionsEqualToSizes:(NSArray *)sizes {
    return [[self alloc] initWithDimensions:sizes type:EqualityTypeEqual];
}

+ (instancetype)descriptorWithDimensionsEqualToSize:(CGSize)size {
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:EqualityTypeEqual];
}

+ (instancetype)descriptorWithDimmensionsLessThanSize:(CGSize)size orEqual:(BOOL)equal {
    EqualityType type = equal ? EqualityTypeLessThanOrEqual : EqualityTypeLessThan;
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:type];
}

+ (instancetype)descriptorWithDimmensionsGreaterThanSize:(CGSize)size orEqual:(BOOL)equal {
    EqualityType type = equal ? EqualityTypeGreaterThanOrEqual : EqualityTypeGreaterThan;
    return [[self alloc] initWithDimensions:@[TSSizeValue(size.width, size.height)] type:type];
}


+ (instancetype)filterWithDimensions:(NSArray *)dimensions type:(EqualityType)type {
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

- (BOOL)isSizeMatchToFilter:(CGSize)size {
    BOOL result = NO;
    for (NSValue *value in _dimensions) {
        CGSize sizeValue = [value CGSizeValue];
        BOOL compareResult = [TSSizeComparator compareSize:size toSize:sizeValue withEquality:_equalityType];
//        NSLog(@"result = %d", compareResult);
        if (compareResult) {
//            NSLog(@"%@", NSStringFromCGSize(size));
            result = YES;
            break;
        }
    }
    
    return result;
}

@end
