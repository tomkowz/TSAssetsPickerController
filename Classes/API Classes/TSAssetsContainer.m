//
//  TSAssetContainer
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsContainer.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSAssetsContainer {
    NSMutableArray *_assets;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _assets = [NSMutableArray new];
    }
    return self;
}

- (void)setAssets:(NSArray *)assets {
    _assets = [NSMutableArray arrayWithArray:assets];
}

- (void)addAsset:(ALAsset *)asset {
    if (![self assetExists:asset]) [_assets addObject:asset];
}

- (void)removeAsset:(ALAsset *)asset {
    ALAsset *assetToRemove = [self assetSimilarTo:asset];
    if (assetToRemove)
        [_assets removeObject:assetToRemove];
}

- (void)removeAllAssets {
    [_assets removeAllObjects];
}

- (BOOL)assetExists:(ALAsset *)asset {
    return ([self assetSimilarTo:asset] != nil);
}

- (ALAsset *)assetSimilarTo:(ALAsset *)asset {
    ALAsset *similarAsset = nil;
    
    NSURL *assetURL = [asset defaultRepresentation].url;
    for (ALAsset *a in _assets) {
        NSURL *aURL = [a defaultRepresentation].url;
        
        if ([assetURL isEqual:aURL]) {
            similarAsset = a;
            break;
        }
    }
    return similarAsset;
}


#pragma mark - Accessors
- (NSUInteger)count {
    return _assets.count;
}

@end
