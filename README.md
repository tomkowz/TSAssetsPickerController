You can donate this project. [![image](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=szulc%2etomasz%40o2%2epl&lc=US&item_name=Donate%20for%20TSAssetsPickerController&item_number=TSAssetsPickerController&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted)

TSAssetsPickerController
========================
<p>&nbsp;</p>
<p><p align="center"><img src="https://raw.github.com/tomkowz/TSAssetsPickerController/master/docs/demo.gif"/></p></p>



TSAssetPickerController is a custom picker controller which allows you to select multiple assets from Camera Roll.

I decided to share this picker because it's easy to add to the project, easy to maintain and it works very well. This picker is used by [iWrapper app](https://itunes.apple.com/pl/app/iwrapper-superb-screenshots/id549973157?mt=8). Try it and apply to your projects.

Cocoapods
========================
`TSAssetsPickerController` is available on [CocoaPods](http://cocoapods.org)


Why should You use it?
========================
Why should you write the same controller from scratch? :)


What it can do?
========================
This picker allows you to select multiple (defined by you) assets and do what you want with them. 

It supports photo and video assets. Video assets has thumbnail with little "play" mark. 

- Browse all albums
- Set filters (only Photos, only Videos, All)
- Supports all orientations
- Supports both iOS 6 and iOS7
- Supports both iPhone and iPad
- Select multiple assets from one album
- Customizable order of displaying assets, last-first, first-first (iWrapper has last-first, it cause that user can't scroll 1000+ elements to get latest asset)
- Picker has plenty of properties to customize, look below
- Easy to apply in your project
- Easy to customize


Settings
========================
`TSAssetsPickerController` has plenty of properties to set.


| Property                      		| Type           	| Default value 		|
| ------------------------------------- | -----------------	| ---------------------:|
| numberOfItemsToSelect					| `NSUInteger`		| 1						|
| filter								| `ALAssetsFilter`	| allPhotos				|
| albumsViewControllerTitle				| `NSString`		| Albums				|
| cancelButtonTitle						| `NSString`		| Cancel				|
| selectButtonTitle						| `NSString`		| Select				|
| noAlbumsForSelectedFilter				| `NSString`		| some string			|
| shouldReverseAlbumsOrder				| `BOOL`			| YES					|
| shouldReverseAssetsOrder				| `BOOL`			| YES					|
| shouldShowEmptyAlbums					| `BOOL`			| NO					|
| shouldDimmEmptyAlbums					| `BOOL`			| YES					|
| subclassOfAlbumCellClass				| `Class`			| AlbumCell				|
| subclassOfNoAlbumsCell				| `Class`			| NoAlbumsCell			|
| subclassOfAlbumsTableViewClass		| `Class`			| AlbumsTableView		|
| subclassOfAssetCell					| `Class`			| AssetCell				|
| subclassOfAssetsFlowLayoutClass		| `Class`			| AssetsFlowLayout 		|
| subclassOfAssetsCollectionViewClass 	| `Class`			| AssetsCollectionView 	|


There is also `TSAssetsPickerControllerDelegate` protocol which is very similar to `UIImagePickerControllerDelegate`.

`- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;` - returns array of ALAssets objects when user finish selecting items.

`- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker` - called when user tap "Cancel"

`- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error` - called when error occurs


Properties of `TSAssetsPickerController` with description
========================

```objective-c
@interface TSAssetsPickerController : UINavigationController
@property (nonatomic, weak) id <TSAssetsPickerControllerDelegate, 
    UINavigationControllerDelegate> delegate;

/**
 Maximum number of items selected in one time. Defaults 1.
 */
@property (nonatomic) NSUInteger numberOfItemsToSelect;

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
 Set this class if you want to use custom subclass of AlbumsTableView class.
 This class is UITableView placed in TSAlbumsTableView.
 */
@property (nonatomic) Class subclassOfAlbumsTableViewClass;

/**
 Set this class if you want to use custom subclass of AssetCell class.
 This class is used to display assets in Assets view (UICollectionViewCell).
 */
@property (nonatomic) Class subclassOfAssetCellClass;

/**
 Set this class if you want to use custom subclass of AssetsFlowLayout class.
 This class is a layout of UICollectionView of TSAssetsViewController.
 */
@property (nonatomic) Class subclassOfAssetsFlowLayoutClass;

/**
 Set this class if you want to use custom subclass of AssetsCollectionView class.
 This class is UICollectionView placed in TSAssetsViewController.
 */
@property (nonatomic) Class subclassOfAssetsCollectionViewClass;

@end
```


How it works?
========================

It consists of two parts:
- API
- View Controllers


API
========================
![image](https://github.com/tomkowz/TSAssetsPickerController/blob/master/docs/diag1.png?raw=true)


View Controllers
========================
![image](https://github.com/tomkowz/TSAssetsPickerController/blob/master/docs/diag2.png?raw=true)


Classes
========================
Classes are stored in 3 folders:

`Controllers` - View Controllers. Only `TSAssetsPickerController` is important to you.

`Customizable Classes` - In this directory are classes you should subclass if you want change picker's UI.

`API Classes` - Picker's logic. Not important to you.


`Controlers` directory:
---

`TSAssetsPickerController` - This is a picker controller main class. You present this controller if you want to show picker on the screen. 

`TSAlbumsViewController` - shows list of albums

`TSAssetsViewController` - shows list of assets


`Customizable Classes` directory:
---

These classes should be subclassed and set in `TSAssetsPickerController` properties (if you want customize the picker).

`AlbumCell` - Base class of cell which is displayed on `TSAlbumsViewController` (cell with album name).

`NoAlbumsCell` - Base class of cell which is displayed on `TSAlbumsViewController` when there is no albums.

`AssetCell` - Base class of cell which is displayed on `TSAssetsViewController`.

`AssetsFlowLayout` - Base class of flow layout used in `TSAssetsViewController`. Remember to not override `-itemSize` method. Size of item is read from `[AssetCell preferedCellSize]` automatically.

`AssetsCollectionView` -  Base class of `UICollectionView` used in `TSAssetsViewController`. subclass this base and configure in `TSAssetsPickerController`.

`API Classes` directory:
---

`TSBaseLoader` with `ALAssets` objects, and also it keeps information about which filter should be use when browsing albums and assets.

`TSAlbumsLoader` - the same as above, can fetch album names.

`TSAssetsLoader` - the same as `TSBaseLoader`, can fetch assets from selected album.

`TSAssetsContainer` - This class is container which can store and manage ALAssets objects. It is used by `TSAssetsManager` class.

`TSAssetsManager` - This classes is used directly by `TSAssetsViewController`. Instance is initialized with `TSAssetsLoader` object. It keeps information about fetched and selected assets. It can fetch assets via `TSAssetsLoader`. Also it can mark assets as selected or deselected and check if asset exists.

`AlbumRepresentation` - This class represents album.



How to use
========================
1. Import /Classes directory to your project
2. Write some init code

````objective-c
    if (!_picker) {
        _picker = [TSAssetsPickerController new];
        _picker.delegate = self;
        
        // Main configuration
        _picker.numberOfItemsToSelect = 3;
        
        _picker.albumsViewControllerTitle = @"Albumy";
        _picker.selectButtonTitle = @"Wybierz";
        _picker.cancelButtonTitle = @"Anuluj";
        
        _picker.filter = [ALAssetsFilter allAssets];
        _picker.noAlbumsForSelectedFilter = @"Can't find any asset. Create some and back.";
        
        _picker.shouldReverseAlbumsOrder = NO;
        _picker.shouldReverseAssetsOrder = YES;
        
        _picker.shouldShowEmptyAlbums = YES;
        _picker.shouldDimmEmptyAlbums = NO;
        
        
        // Set subclasses of cell classes to custom UI.
        _picker.subclassOfAlbumCellClass = [DummyAlbumCell class];
        _picker.subclassOfNoAlbumsCellClass = [DummyNoAlbumsCell class];
        _picker.subclassOfAssetCellClass = [DummyAssetCell class];
        _picker.subclassOfAssetsFlowLayoutClass = [DummyAssetsFlowLayout class];
        _picker.subclassOfAssetsCollectionViewClass = [DummyAssetsCollectionView class];
    }

    [self presentViewController:_picker animated:YES completion:nil];
````

Changelog
========================

1.0.2 (23.02.2014)
---
- Added Podspec of TSAssetsPickerController. Now available on [CocoaPods](http://cocoapods.org)

1.0.1 (23.02.2014)
---
- Added rotation support

1.0 (22.02.2014)
---
- Implemented basic functionality
- Added to github

License
========================

TSAssetsPickerController is available under the Apache 2.0 license.

Copyright © 2014 Tomasz Szulc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
