//
//  TSFilterDimensionsDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TSSizeValue(width,height) [NSValue valueWithCGSize:CGSizeMake(width,height)]

@interface TSAssetsFilterDimensionsDescriptor : NSObject

/// OR - asset size matches if one of the sizes is correct.
+ (instancetype)filterWithDimensionsEqualTo:(NSArray *)array;
- (BOOL)isSizeMatchToFilter:(CGSize)size;

@end
