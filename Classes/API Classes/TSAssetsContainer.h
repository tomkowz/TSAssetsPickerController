//
//  TSAssetContainer
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset, ALAssetsLibrary;

@interface TSAssetsContainer : NSObject

@property (nonatomic, readonly) NSArray *assets;
@property (nonatomic, readonly) NSUInteger count;

- (void)setAssets:(NSArray *)assets;

- (void)addAsset:(ALAsset *)asset;
- (void)removeAsset:(ALAsset *)asset;

- (void)removeAllAssets;

- (ALAsset *)assetSimilarTo:(ALAsset *)asset;

@end
