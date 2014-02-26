//
//  TSAlbumLoader.m
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAlbumsLoader.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "AlbumRepresentation.h"
#import "TSFilter.h"

@implementation TSAlbumsLoader

@synthesize fetchedAlbumRepresentations = _fetchedAlbumRepresentations;

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(TSFilter *)filter {
    self = [super initWithLibrary:library filter:filter];
    if (self) {
        _shouldReturnEmptyAlbums = NO;
    }
    return self;
}

- (void)fetchAlbumNames:(void (^)(NSArray *, NSError *))block {
    [self removeFetchedObjects];
    NSMutableArray *albumRepresentations = [NSMutableArray array];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                            usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                if (group) {
                                    __block AlbumRepresentation *representation = nil;
                                    
                                    [group setAssetsFilter:self.filter.assetsFilter];
                                    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                        if (!representation) {
                                            BOOL matchToFilter = NO;
                                            if (result) {
                                                CGSize assetSize = [result.defaultRepresentation dimensions];
                                                matchToFilter = [self.filter isSizeMatchToDimensionFilters:assetSize];
                                            }
                                            
                                            if (matchToFilter || _shouldReturnEmptyAlbums) {
                                                NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
                                                representation = [AlbumRepresentation albumRepresentationWithName:groupName isEmpty:(result == nil)];
                                                *stop = YES;
                                            }
                                        }
                                    }];
                                    
                                    if (representation) {
                                        [albumRepresentations addObject:representation];
                                        _fetchedAlbumRepresentations = [NSArray arrayWithArray:albumRepresentations];
                                        block(_fetchedAlbumRepresentations, nil);
                                    }
                                    
                                    if (albumRepresentations.count == 0) {
                                        block([NSArray array], nil);
                                    }
                                }
                            } failureBlock:^(NSError *error) {
                                block([NSArray array], error);
                            }];
}

- (void)removeFetchedObjects {
    _fetchedAlbumRepresentations = [NSArray array];
}

- (NSArray *)fetchedAlbums {
    NSArray *array = _fetchedAlbumRepresentations;
    if (self.shouldReverseOrder) {
        array = array.reverseObjectEnumerator.allObjects;
    }
    
    return array;
}

@end
