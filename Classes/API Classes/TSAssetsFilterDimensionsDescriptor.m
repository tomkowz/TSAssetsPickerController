//
//  TSFilterDimensionsDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsFilterDimensionsDescriptor.h"

typedef enum {
    EqualityTypeNotEqual,
    EqualityTypeEqual,
    EqualityTypeGreaterThan,
    EqualityTypeGreaterThanOrEqual,
    EqualityTypeLessThan,
    EqualityTypeLessThanOrEqual
} EqualityType;

@implementation TSAssetsFilterDimensionsDescriptor {
    NSArray *_dimensions;
    EqualityType _equalityType;
}

+ (instancetype)filterWithDimensionsEqualTo:(NSArray *)array {
    return [[self alloc] initWithDimensions:array type:EqualityTypeEqual];
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
    BOOL result = YES;
    for (NSValue *value in _dimensions) {
        CGSize sizeValue = [value CGSizeValue];
        BOOL compareResult = [self compareSize:size toSize:sizeValue withEquality:_equalityType];
//        NSLog(@"result = %d", compareResult);
        if (!compareResult) {
            result = NO;
            break;
        }
    }
    
    return result;
}

- (BOOL)compareSize:(CGSize)size1 toSize:(CGSize)size2 withEquality:(EqualityType)equalityType {
    BOOL result = NO;
    switch (equalityType) {
        case EqualityTypeEqual:
//            NSLog(@"%@ == %@", NSStringFromCGSize(size1), NSStringFromCGSize(size2));
            result = [self isSize:size1 equalTo:size2];
            break;
            
        case EqualityTypeNotEqual:
            result = [self isSize:size1 notEqualTo:size2];
            break;
            
        case EqualityTypeGreaterThan:
            result = [self isSize:size1 greaterThan:size2];
            break;
            
        case EqualityTypeGreaterThanOrEqual:
            result = [self isSize:size1 greaterThanOrEqualTo:size2];
            break;
            
        case EqualityTypeLessThan:
            result = [self isSize:size1 lessThan:size2];
            break;
            
        case EqualityTypeLessThanOrEqual:
            result = [self isSize:size1 lessThanOrEqualTo:size2];
            break;
    }
    return result;
}

#pragma mark - Compare
- (BOOL)isSize:(CGSize)size1 equalTo:(CGSize)size2 {
    return CGSizeEqualToSize(size1, size2);
}

- (BOOL)isSize:(CGSize)size1 notEqualTo:(CGSize)size2 {
    return ![self isSize:size1 equalTo:size2];
}

- (BOOL)isSize:(CGSize)size1 greaterThan:(CGSize)size2 {
    return [self isSize:size1 greaterThan:size2 canBeEqual:NO];
}

- (BOOL)isSize:(CGSize)size1 greaterThanOrEqualTo:(CGSize)size2 {
    return [self isSize:size1 greaterThan:size2 canBeEqual:YES];
}

- (BOOL)isSize:(CGSize)size1 lessThan:(CGSize)size2 {
    return [self isSize:size1 lessThan:size2 canBeEqual:NO];
}

- (BOOL)isSize:(CGSize)size1 lessThanOrEqualTo:(CGSize)size2 {
    return [self isSize:size1 lessThan:size2 canBeEqual:YES];
}

- (BOOL)isSize:(CGSize)size1 greaterThan:(CGSize)size2 canBeEqual:(BOOL)canBeEqual {

    BOOL result = NO;
    
    BOOL isWidthEqual = size1.width == size2.width;
    BOOL isHeightEqual = size1.height == size2.height;
    
    BOOL isWidthGreater = size1.width > size2.width;
    BOOL isHeightGreater = size1.height > size2.height;
    
    if (!canBeEqual) {
        result = (isWidthGreater && isHeightGreater);
    } else {
        result = ((isWidthGreater || isWidthEqual) &&
                  (isHeightGreater || isHeightEqual));
    }
    
    return result;
}

- (BOOL)isSize:(CGSize)size1 lessThan:(CGSize)size2 canBeEqual:(BOOL)canBeEqual {
    
    BOOL result = NO;
    
    BOOL isWidthEqual = size1.width == size2.width;
    BOOL isHeightEqual = size1.height == size2.height;
    
    BOOL isWidthLess = size1.width < size2.width;
    BOOL isHeightLess = size1.height < size2.height;
    
    if (!canBeEqual) {
        result = (isWidthLess && isHeightLess);
    } else {
        result = ((isWidthLess || isWidthEqual) &&
                  (isHeightLess || isHeightEqual));
    }
    
    return result;
}

@end
