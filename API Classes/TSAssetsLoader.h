//
//  IWAssetsManager.h
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary, ALAssetsFilter;

@interface TSAssetsLoader : NSObject
@property (nonatomic, readonly) ALAssetsLibrary *library;
@property (nonatomic, readonly) ALAssetsFilter *filter;
@property (nonatomic, readonly) NSArray *fetchedAssets;

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter;
- (void)fetchAssetsFromAlbum:(NSString *)album block:(void (^)(NSArray *loadedAssets))block;

@end
