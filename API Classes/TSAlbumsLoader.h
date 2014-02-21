//
//  TSAlbumLoader.h
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary, ALAssetsFilter;

@interface TSAlbumsLoader : NSObject
@property (nonatomic, readonly) ALAssetsLibrary *library;
@property (nonatomic, readonly) ALAssetsFilter *filter;

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter;

- (void)fetchAlbumNames:(void (^)(NSString *albumName))block;

@end
