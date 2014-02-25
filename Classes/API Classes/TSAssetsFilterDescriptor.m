//
//  TSFilterDescriptor.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsFilterDescriptor.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSAssetsFilterDescriptor

@end

@implementation TSAssetsFilterDescriptor (AssetsLibrary)

- (ALAssetsFilter *)assetsFilter {
    ALAssetsFilter *filter = nil;
    switch (_filterType) {
        case FilterTypePhoto:
            filter = [ALAssetsFilter allPhotos];
            break;
            
        case FilterTypeVideo:
            filter = [ALAssetsFilter allVideos];
            break;
            
        case FilterTypeAll:
            filter = [ALAssetsFilter allAssets];
            break;
            
        default:
            break;
    }
    
    return filter;
}

@end