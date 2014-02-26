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

@interface TSSizePredicate : NSObject

+ (instancetype)matchSizes:(NSArray *)sizes;
+ (instancetype)matchSize:(CGSize)size;
+ (instancetype)matchSizeLessThan:(CGSize)size orEqual:(BOOL)equal;
+ (instancetype)matchSizeGreaterThan:(CGSize)size orEqual:(BOOL)equal;

- (BOOL)isSizeMatch:(CGSize)size;

@end
