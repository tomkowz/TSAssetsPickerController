//
//  TSAssetContainer
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset, ALAssetsLibrary;

@interface TSAssetsContainer : NSObject

@property (nonatomic, readonly) ALAssetsLibrary *library;
@property (nonatomic, readonly) NSArray *assets;
@property (nonatomic, readonly) BOOL count;

- (void)setAssets:(NSArray *)assets;

- (void)addAsset:(ALAsset *)asset;
- (void)removeAsset:(ALAsset *)asset;

- (void)removeAllAssets;

- (ALAsset *)existsAssetSimilarTo:(ALAsset *)asset;

@end
