//
//  TSFilterDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSFilter.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "TSSizePredicate.h"

@interface TSFilter ()
@property (nonatomic) FilterType filterType;
@property (nonatomic) NSArray *predicates;
@property (nonatomic) LogicGateType logicGateType;
@end

@implementation TSFilter

+ (instancetype)filterWithType:(FilterType)type {
    return [[self alloc] initWithType:type predicates:nil logicGateType:OR];
}

+ (instancetype)filterWithType:(FilterType)type predicate:(TSSizePredicate *)predicate {
    return [[self alloc] initWithType:type predicates:@[predicate] logicGateType:OR];
}

+ (instancetype)filterWithType:(FilterType)type predicates:(NSArray *)predicates logicGateType:(LogicGateType)logicGateType {
    return [[self alloc] initWithType:type predicates:predicates logicGateType:logicGateType];
}

- (instancetype)initWithType:(FilterType)type predicates:(NSArray *)predicates logicGateType:(LogicGateType)logicGateType {
    self = [super init];
    if (self) {
        _filterType = type;
        _predicates = predicates;
        _logicGateType = logicGateType;
    }
    return self;
}

- (BOOL)isSizeMatch:(CGSize)size {
    BOOL match = NO;
    
    if (_predicates) {
        NSMutableArray *results = [NSMutableArray array];
        for (TSSizePredicate *descriptor in _predicates) {
            BOOL result = [descriptor isSizeMatch:size];
            [results addObject:@(result)];
        }
        
        if (_logicGateType == OR) {
            for (NSNumber *resultObject in results) {
                if ([resultObject boolValue]) {
                    match = YES;
                    break;
                }
            }
        } else if (_logicGateType == AND) {
            match = YES;
            for (NSNumber *resultObject in results) {
                if (![resultObject boolValue]) {
                    match = NO;
                    break;
                }
            }
        }
    } else {
        match = YES;
    }
    
    return match;
}

@end



@implementation TSFilter (AssetsLibrary)

- (ALAssetsFilter *)assetsFilter {
    ALAssetsFilter *filter = nil;
    switch (_filterType) {
        case FilterTypePhoto:
            filter = [ALAssetsFilter allPhotos];
            break;
            
        case FilterTypeVideo:
            filter = [ALAssetsFilter allVideos];
            break;
            
        case FilterTypeAll:
            filter = [ALAssetsFilter allAssets];
            break;
    }
    
    return filter;
}

@end