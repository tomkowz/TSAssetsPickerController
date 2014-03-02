//
//  TSAssetsPickerController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Framework
#import <AssetsLibrary/AssetsLibrary.h>

/// Predicates
#import "TSFilter.h"
#import "TSSizePredicate.h"

/// UI Classes
#import "AlbumCell.h"
#import "NoAlbumsCell.h"
#import "AlbumsTableView.h"
#import "AssetCell.h"
#import "AssetsCollectionView.h"

@class TSFilter;
@protocol TSAssetsPickerControllerDelegate;
@protocol TSAssetsPickerControllerDataSource;

typedef enum {
    AlbumsView,
    AssetsView
} ViewPlace;

@interface TSAssetsPickerController : UINavigationController
@property (nonatomic, weak) id <TSAssetsPickerControllerDelegate, UINavigationControllerDelegate> delegate;
@property (nonatomic, weak) id <TSAssetsPickerControllerDataSource> dataSource;

@end


@protocol TSAssetsPickerControllerDataSource <NSObject>
/// Maximum number of items selected in one time.
- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker;

/// Filter used to filtering assets.
- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker;

@optional
/// Method called when assets collection view needs layout (e.g. when change orientation)
- (UICollectionViewLayout *)assetsPickerController:(TSAssetsPickerController *)picker needsLayoutForOrientation:(UIInterfaceOrientation)orientation;

- (UIActivityIndicatorView *)assetsPickerController:(TSAssetsPickerController *)picker activityIndicatorViewForPlaceIn:(ViewPlace)place;

/// Title of TSAlbumsViewController
- (NSString *)assetsPickerControllerTitleForAlbumsView:(TSAssetsPickerController *)picker;

/// Title of cancel button. Defaults "Cancel"
- (NSString *)assetsPickerControllerTitleForCancelButtonInAlbumsView:(TSAssetsPickerController *)picker;

/// Title of select button. Defaults "Select"
- (NSString *)assetsPickerControllerTitleForSelectButtonInAssetsView:(TSAssetsPickerController *)picker;

/**
 This text is displayed in NoAlbumsCell.
 Text is displayed when there is no albums for selected filter.
 Defaults "No albums for selected filter".
 */
- (NSString *)assetsPickerControllerTextForCellWhenNoAlbumsAvailable:(TSAssetsPickerController *)picker;

/// Define albums order. Defaults NO.
- (BOOL)assetsPickerControllerShouldReverseAlbumsOrder:(TSAssetsPickerController *)picker;

/// Define assets order. YES if last-first, NO if first-first. Defaults YES.
- (BOOL)assetsPickerControllerShouldReverseAssetsOrder:(TSAssetsPickerController *)picker;

/// Method determines if picker should display empty albums. Defaults NO.
- (BOOL)assetsPickerControllerShouldShowEmptyAlbums:(TSAssetsPickerController *)picker;

/** 
 Method determines if picker should dimm empty albums (It dimss labels in AlbumCell).
 Use only if you return YES for shouldShowEmptyAlbums. Defaults YES.
 */
- (BOOL)assetsPickerControllerShouldDimmCellsForEmptyAlbums:(TSAssetsPickerController *)picker;

/// Use this method if you want to use subclass of UI classes used by picker, such cells, table view, collection view.
- (Class)assetsPickerController:(TSAssetsPickerController *)picker subclassForClass:(Class)aClass;

@end

@protocol TSAssetsPickerControllerDelegate <NSObject>
- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker;
- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error;
@end