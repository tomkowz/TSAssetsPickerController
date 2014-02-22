//
//  TSAssetsPickerControllerConfiguration.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AssetCell+Configuration.h"

@class ALAssetsFilter;
@class TSAssetCellConfiguration;

@interface TSAssetsPickerControllerConfiguration : NSObject

@property (nonatomic) NSUInteger numberOfItemsToSelect; // default set to 1

@property (nonatomic) ALAssetsFilter *filter; // default Photo
@property (nonatomic, copy) NSString *noAlbumsForSelectedFilter; // default: No albums for selected filter

@property (nonatomic) BOOL shouldReverseAlbumsOrder; // default set to YES
@property (nonatomic) BOOL shouldReverseAssetsOrder; // default set to YES;

@property (nonatomic) BOOL shouldShowEmptyAlbums; // default set to NO;
@property (nonatomic) BOOL shouldDimmEmptyAlbums; // default set to YES; Works only if shouldShowEmptyAlbums is set to YES

@end
