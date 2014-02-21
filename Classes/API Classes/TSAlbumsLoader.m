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

- (void)fetchAlbumNames:(void (^)(NSArray *))block {
    [self removeFetchedObjects];
    NSMutableArray *fetchedAlbumNames = [NSMutableArray array];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                            usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                if (group) {
                                    __block NSString *groupName = nil;
                                    [group setAssetsFilter:self.filter];
                                    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                        if (result) {
                                            groupName = [group valueForProperty:ALAssetsGroupPropertyName];
                                            *stop = YES;
                                        }
                                    }];
                                    
                                    if (groupName) {
                                        [fetchedAlbumNames addObject:groupName];
                                        _fetchedAlbumNames = [NSArray arrayWithArray:fetchedAlbumNames];
                                        block(_fetchedAlbumNames);
                                    }
                                }
                            } failureBlock:^(NSError *error) {
                                block(nil);
                            }];
}

- (void)removeFetchedObjects {
    _fetchedAlbumNames = [NSArray array];
}

@end
