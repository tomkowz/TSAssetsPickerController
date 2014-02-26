//
//  TSFilterDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSFilter.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "TSDescriptor.h"

@interface TSFilter ()
@property (nonatomic) FilterType filterType;
@property (nonatomic) NSArray *descriptors;
@property (nonatomic) LogicGateType logicGateType;
@end

@implementation TSFilter

+ (instancetype)filterWithType:(FilterType)type descriptor:(TSDescriptor *)descriptor {
    return [[self alloc] initWithType:type descriptors:@[descriptor] logicGateType:OR];
}

+ (instancetype)filterWithType:(FilterType)type descriptors:(NSArray *)descriptors logicGateType:(LogicGateType)logicGateType {
    return [[self alloc] initWithType:type descriptors:descriptors logicGateType:logicGateType];
}

- (instancetype)initWithType:(FilterType)type descriptors:(NSArray *)descriptors logicGateType:(LogicGateType)logicGateType {
    self = [super init];
    if (self) {
        _filterType = type;
        _descriptors = descriptors;
        _logicGateType = logicGateType;
    }
    return self;
}

- (BOOL)isSizeMatchToDimensionFilters:(CGSize)size {
    BOOL match = NO;
    
    NSMutableArray *results = [NSMutableArray array];
    for (TSDescriptor *descriptor in _descriptors) {
        BOOL result = [descriptor isSizeMatchToFilter:size];
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