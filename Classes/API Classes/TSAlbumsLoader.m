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

@synthesize fetchedAlbumNames = _fetchedAlbumNames;

- (void)fetchAlbumNames:(void (^)(NSArray *, NSError *))block {
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
                                        block(_fetchedAlbumNames, nil);
                                    }
                                }
                            } failureBlock:^(NSError *error) {
                                block([NSArray array], error);
                            }];
}

- (void)removeFetchedObjects {
    _fetchedAlbumNames = [NSArray array];
}

- (NSArray *)fetchedAlbumNames {
    NSArray *array = _fetchedAlbumNames;
    if (self.shouldReverseOrder) {
        array = array.reverseObjectEnumerator.allObjects;
    }
    
    return array;
}

@end
