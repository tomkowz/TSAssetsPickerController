//
//  TSAssetsPickerControllerConfiguration.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerControllerConfiguration.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSAssetsPickerControllerConfiguration

- (id)init {
    self = [super init];
    if (self) {
        [self _setDefaultConfiguration];
    }
    return self;
}

- (void)_setDefaultConfiguration {
    _numberOfItemsToSelect = 1;
    
    _filter = [ALAssetsFilter allPhotos];
    _noAlbumsForSelectedFilter = @"No albums for selected filter";
    
    _shouldReverseAlbumsOrder = YES;
    _shouldReverseAssetsOrder = YES;
    
    _shouldShowEmptyAlbums = NO;
    _shouldDimmEmptyAlbums = YES;
}

@end
