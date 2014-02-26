//
//  TSFilterDescriptor.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsFilter;
@class TSSizePredicate;

typedef enum {
    FilterTypePhoto,
    FilterTypeVideo,
    FilterTypeAll
} FilterType;

typedef enum {
    OR,
    AND
} LogicGateType;

@interface TSFilter : NSObject

+ (instancetype)filterWithType:(FilterType)type;
+ (instancetype)filterWithType:(FilterType)type predicate:(TSSizePredicate *)predicate;
+ (instancetype)filterWithType:(FilterType)type predicates:(NSArray *)predicates logicGateType:(LogicGateType)logicGateType;

- (BOOL)isSizeMatch:(CGSize)size;

@end

@interface TSFilter (AssetsLibrary)
@property (nonatomic, readonly) ALAssetsFilter *assetsFilter;
@end
