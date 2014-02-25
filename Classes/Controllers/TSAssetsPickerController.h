//
//  TSAssetsPickerController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@protocol TSAssetsPickerControllerDelegate;
@protocol TSAssetsPickerControllerDataSource;

@interface TSAssetsPickerController : UINavigationController
@property (nonatomic, weak) id <TSAssetsPickerControllerDelegate, UINavigationControllerDelegate> delegate;
@property (nonatomic, weak) id <TSAssetsPickerControllerDataSource> dataSource;


/**
 Filter used to filter assets in Camera Roll. Defaults Photo.
 */
@property (nonatomic) ALAssetsFilter *filter;

/**
 Title of TSAlbumsViewController 
 */
@property (nonatomic, copy) NSString *albumsViewControllerTitle;

/**
 Title of cancel button. Defaults "Cancel"
 */
@property (nonatomic, copy) NSString *cancelButtonTitle;

/**
 Title of select button. Defaults "Select"
 */
@property (nonatomic, copy) NSString *selectButtonTitle;

/**
 This text is displayed in NoAlbumsCell and subclasses of it.
 Text is displayed when there is no albums for selected filter.
 Defaults "No albums for selected filter".
 */
@property (nonatomic, copy) NSString *noAlbumsForSelectedFilter;

/**
 This flag determines if albums order should be reveresed, last-first.
 Defaults YES.
 */
@property (nonatomic) BOOL shouldReverseAlbumsOrder;

/**
 This flag determines if assets order in albums should be reversed, last-first.
 Defaults YES.
 */
@property (nonatomic) BOOL shouldReverseAssetsOrder;

/**
 This flag determines if picker should display empty albums.
 Defaults NO.
 */
@property (nonatomic) BOOL shouldShowEmptyAlbums;

/**
 this flag determines if picker should dimm empty albums (It dimss labels in AlbumCell).
 */
@property (nonatomic) BOOL shouldDimmEmptyAlbums;

@end


@protocol TSAssetsPickerControllerDataSource <NSObject>

/// Maximum number of items selected in one time. Defaults 1.
- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker;

@optional
/// Use this method if you want to use subclass of UI classes used by picker, such cells, table view, collection view.
- (Class)assetsPickerController:(TSAssetsPickerController *)picker subclassForClass:(Class)aClass;

@end

@protocol TSAssetsPickerControllerDelegate <NSObject>
- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker;
- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error;
@end