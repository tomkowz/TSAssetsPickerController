//
//  TSAlbumLoader.m
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAlbumsLoader.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSAlbumsLoader

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter {
    NSParameterAssert(library);
    NSParameterAssert(filter);
    
    self = [super init];
    if (self) {
        _library = library;
        _filter = filter;
    }
    return self;
}

- (void)fetchAlbumNames:(void (^)(NSString *albumName))block {
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll
                            usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                if (group) {
                                    __block NSString *groupName = @"";
                                    [group setAssetsFilter:_filter];
                                    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                        if (result) {
                                            groupName = [group valueForProperty:ALAssetsGroupPropertyName];
                                            block(groupName);
                                            *stop = YES;
                                        }
                                    }];
                                }
                            } failureBlock:^(NSError *error) {
                                block(nil);
                            }];
}

@end
