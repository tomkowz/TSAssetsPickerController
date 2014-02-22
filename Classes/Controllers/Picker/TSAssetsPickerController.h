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

@interface TSAssetsPickerController : UINavigationController
@property (nonatomic, weak) id <TSAssetsPickerControllerDelegate, UINavigationControllerDelegate> delegate;

/**
 Maximum number of items selected in one time. Defaults 1.
 */
@property (nonatomic) NSUInteger numberOfItemsToSelect;

/**
 Filter used to filter assets in Camera Roll. Defaults Photo.
 */
@property (nonatomic) ALAssetsFilter *filter;

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

/**
 Set this class if you want to use custom subclass of AlbumCell class.
 This class is used to dislpay album (label with name) on Albums view.
 */
@property (nonatomic) Class subclassOfAlbumCellClass;

/**
 Set this class if you want to use custom subclass of NoAlbumsCell class.
 This class is used to display "noAlbumsForSelectedFilter" property on Albums view.
 */
@property (nonatomic) Class subclassOfNoAlbumsCellClass;

/**
 Set this class if you want to use custom subclass of AssetCell class.
 This class is used to display assets in Assets view (UICollectionViewCell).
 */
@property (nonatomic) Class subclassOfAssetCellClass;

@end

@protocol TSAssetsPickerControllerDelegate <NSObject>
- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker;
- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error;
@end