//
//  IWAssetsManager.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsLoader.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "TSFilter.h"

@implementation TSAssetsLoader

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(TSFilter *)filter {
    self = [super initWithLibrary:library filter:filter];
    if (self) {
        _fetchedAssets = [NSArray array];
    }
    return self;
}

- (void)fetchAssetsFromAlbum:(NSString *)album block:(void (^)(NSArray *, NSError *error))block {
    [self removeFetchedAssets];
    NSMutableArray *mutableAssets = [NSMutableArray new];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                               if (group && [[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:album]) {
                                   [group setAssetsFilter:self.filter.assetsFilter];
                                   [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                       if (result) {
                                           CGSize assetSize = [result.defaultRepresentation dimensions];
                                           BOOL matchToFilter = [self.filter isSizeMatch:assetSize];
                                           if (matchToFilter) {
                                               [mutableAssets addObject:result];
                                           }
                                       }
                                   }];
                                   
                                   _fetchedAssets = [NSArray arrayWithArray:mutableAssets];
                                   block(_fetchedAssets, nil);
                               }
                           }
                         failureBlock:^(NSError *error) {
                             block([NSArray array], error);
                         }];
}

- (void)removeFetchedAssets {
    _fetchedAssets = [NSArray array];
}

@end
