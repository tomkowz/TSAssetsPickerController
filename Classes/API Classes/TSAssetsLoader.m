//
//  IWAssetsManager.m
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsLoader.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSAssetsLoader

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter {
    self = [super initWithLibrary:library filter:filter];
    if (self) {
        _fetchedAssets = [NSArray array];
    }
    return self;
}

- (void)fetchAssetsFromAlbum:(NSString *)album block:(void (^)(NSArray *loadedAssets))block {
    [self removeFetchedAssets];
    NSMutableArray *mutableAssets = [NSMutableArray new];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                               if (group && [[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:album]) {
                                   [group setAssetsFilter:self.filter];
                                   [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                       if (result) {
                                           [mutableAssets addObject:result];
                                       }
                                   }];
                                   
                                   _fetchedAssets = [NSArray arrayWithArray:mutableAssets];
                                   block(_fetchedAssets);
                               }
                           }
                         failureBlock:^(NSError *error) {
                             block(nil);
                         }];
}

- (void)removeFetchedAssets {
    _fetchedAssets = [NSArray array];
}

@end
