//
//  TSFilterDimensionsDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EqualityTypeNotEqual,
    EqualityTypeEqual,
    EqualityTypeGreaterThan,
    EqualityTypeGreaterThanOrEqual,
    EqualityTypeLessThan,
    EqualityTypeLessThanOrEqual
} EqualityType;

@interface TSAssetsFilterDimensionsDescriptor : NSObject
@property (nonatomic, readonly) CGSize dimensions;
@property (nonatomic, readonly) EqualityType equalityType;

+ (instancetype)filterWithDimensions:(CGSize)dimensions type:(EqualityType)type;

@end
