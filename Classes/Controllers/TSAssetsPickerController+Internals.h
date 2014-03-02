//
//  TSAssetsPickerController+Subclasses.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController.h"

@interface TSAssetsPickerController (Internals)

- (NSString *)albumsViewControllerTitle;
- (NSString *)cancelButtonTitle;
- (NSString *)selectButtonTitle;
- (NSString *)noAlbumsForSelectedFilter;
- (UICollectionViewLayout *)assetsCollectionViewLayoutForOrientation:(UIInterfaceOrientation)orientation;
- (UIActivityIndicatorView *)activityIndicatorViewForPlaceIn:(ViewPlace)place;

- (BOOL)shouldShowEmptyAlbums;
- (BOOL)shouldDimmEmptyAlbums;
- (BOOL)shouldReverseAlbumsOrder;
- (BOOL)shouldReverseAssetsOrder;

- (Class)subclassForClass:(Class)aClass;

@end
