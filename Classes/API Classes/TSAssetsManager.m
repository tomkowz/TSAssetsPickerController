//
//  TSAssetsManager.m
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsManager.h"

#import "TSAssetsLoader.h"
#import "TSAssetsContainer.h"

@implementation TSAssetsManager {
    TSAssetsLoader *_assetsLoader;
    TSAssetsContainer *_selectedAssetsContainer;
    TSAssetsContainer *_selectedAssetsAfterUpdateContainer;
}


#pragma mark - Initialization
+ (instancetype)managerWithLoader:(TSAssetsLoader *)loader {
    return [[self alloc] initWithAssetsLoader:loader];
}

- (instancetype)initWithAssetsLoader:(TSAssetsLoader *)loader {
    NSParameterAssert(loader);
    
    self = [super init];
    if (self) {
        _assetsLoader = loader;
        _selectedAssetsContainer = [TSAssetsContainer new];
    }
    return self;
}


- (void)fetchAssetsWithAlbumName:(NSString *)albumName block:(void (^)(NSUInteger, NSError *))block {
    [_assetsLoader fetchAssetsFromAlbum:albumName block:^(NSArray *loadedAssets, NSError *error) {
        if (!error) {
            _selectedAssetsAfterUpdateContainer = [TSAssetsContainer new];
            for (ALAsset *asset in loadedAssets) {
                ALAsset *selectedAsset = [_selectedAssetsContainer assetSimilarTo:asset];
                if (selectedAsset) {
                    [_selectedAssetsAfterUpdateContainer addAsset:asset];
                }
            }
            
            [_selectedAssetsContainer setAssets:_selectedAssetsAfterUpdateContainer.assets];
            block(loadedAssets.count, nil);
        } else {
            block(0, error);
        }
    }];
}

- (void)selectAsset:(ALAsset *)asset {
    [_selectedAssetsContainer addAsset:asset];
}

- (void)deselectAsset:(ALAsset *)asset {
    [_selectedAssetsContainer removeAsset:asset];
}

- (void)deselectAllAssets {
    [_selectedAssetsContainer removeAllAssets];
}

- (BOOL)isAssetSelected:(ALAsset *)asset {
     return ([_selectedAssetsContainer assetSimilarTo:asset] != nil);
}


#pragma mark - Accessors
- (NSArray *)selectedAssets {
    NSArray *array = [NSArray arrayWithArray:_selectedAssetsContainer.assets];
    if (_assetsLoader.shouldReverseOrder) {
        array = array.reverseObjectEnumerator.allObjects;
    }
    return array;
}

- (NSArray *)fetchedAssets {
    NSArray *array = [NSArray arrayWithArray:_assetsLoader.fetchedAssets];
    if (_assetsLoader.shouldReverseOrder) {
        array = array.reverseObjectEnumerator.allObjects;
    }
    return array;
}

@end
