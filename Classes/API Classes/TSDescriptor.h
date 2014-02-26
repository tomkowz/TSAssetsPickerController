//
//  TSFilterDimensionsDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsFilter;

#define TSSizeValue(width,height) [NSValue valueWithCGSize:CGSizeMake(width,height)]

@interface TSDescriptor : NSObject

+ (instancetype)descriptorWithDimensionsEqualToSizes:(NSArray *)sizes;
+ (instancetype)descriptorWithDimensionsEqualToSize:(CGSize)size;
+ (instancetype)descriptorWithDimmensionsLessThanSize:(CGSize)size orEqual:(BOOL)equal;
+ (instancetype)descriptorWithDimmensionsGreaterThanSize:(CGSize)size orEqual:(BOOL)equal;

- (BOOL)isSizeMatchToFilter:(CGSize)size;

@end
