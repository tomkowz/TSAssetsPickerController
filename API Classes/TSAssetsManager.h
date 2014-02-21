//
//  TSAssetsManager.h
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class TSAssetsLoader;

@interface TSAssetsManager : NSObject
@property (nonatomic, readonly) TSAssetsLoader *assetsLoader;

@property (nonatomic, readonly) NSArray *fetchedAssets;
@property (nonatomic, readonly) NSArray *selectedAssets;

+ (instancetype)managerWithLoader:(TSAssetsLoader *)loader;

- (void)fetchAssetsWithAlbumName:(NSString *)albumName block:(void (^)(NSUInteger numberOfAssets))block;

- (void)selectAsset:(ALAsset *)asset;
- (void)deselectAsset:(ALAsset *)asset;
- (BOOL)isAssetSelected:(ALAsset *)asset;

@end
