//
//  TSSizeComparator.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 26.02.2014.
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

@interface TSSizeComparator : NSObject
+ (BOOL)compareSize:(CGSize)size1 toSize:(CGSize)size2 withEquality:(EqualityType)equalityType;
@end
