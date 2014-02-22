//
//  TSAssetsPickerControllerConfiguration.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerControllerConfiguration.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetCell+Configuration.h"
#import "NoAlbumsCell.h"

@implementation TSAssetsPickerControllerConfiguration

- (id)init {
    self = [super init];
    if (self) {
        [self _setDefaultConfiguration];
        [self _setDefaultAssetCellConfiguration];
        [self _setNoAlbumsCellClass];
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

- (void)_setDefaultAssetCellConfiguration {
    [AssetCell setPreferedCellSize:CGSizeMake(74, 74)];
    [AssetCell setPreferedThumbnailRect:CGRectMake(5, 5, 64, 64)];
    [AssetCell setPreferedMovieMarkRect:CGRectMake(46, 46, 20, 20)];
    [AssetCell setPreferedImageForMovieMark:[UIImage imageNamed:@"movieMark"]];
    
    UIColor *normal = [UIColor colorWithWhite:0.7 alpha:0.3];
    [AssetCell setPreferedBackgroundColor:normal forState:Normal];
    
    UIColor *selected = [UIColor colorWithRed:21.0f/255.0f green:150.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    [AssetCell setPreferedBackgroundColor:selected forState:Selected];
}

- (void)_setNoAlbumsCellClass {
    _noAlbumCellClass = [NoAlbumsCell class];
}

@end
