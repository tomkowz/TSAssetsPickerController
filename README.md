# TSAssetsPickerController 
<p>&nbsp;</p>
<p><p align="center"><img src="https://raw.github.com/tomkowz/TSAssetsPickerController/master/docs/demo.gif"/></p></p>

TSAssetsPickerController is a control for iOS which works very similar to `UIImagePickerController`. It has an elegant and carefully designed classes.

# Overview
TSAssetsPickerController is a controller you can use to select multiple assets (ALAsset objects).

#### Features

- Browse all albums
- Asset filtering (type, size)
- Supports all orientations
- Supports iOS6, iOS7
- Supports iPhone, iPad
- Allows to select multiple assets from one album
- Customizable order of albums and assets,
- Plenty of options to set.
- Easy to apply in your project
- Easy to customize
<br><br>

# API Quickstart
There is few topics you should know about. Most important classes are `TSAssetsPickerController`, its `delegate` and `dataSource`, `TSFilter` with `TSSizePredicate` class, and UI classes which you can subclass to customize TSAssetsPickerController's UI.

TSAssetsPickerController uses `TSAssetsPickerControllerDelegate` and `TSAssetsPickerControllerDataSource`.

<br>
## TSAssetsPickerControllerDelegate
Delegate has methods which your class have to implements. These methods are called when user finish picking assets, when user tapped cancel and when error occurs. 

Method with error is called when user prohibits access to its Camera Roll. 

Method which is called when user finished picking assets returns ALAssets objects. You can simply get picture or video from those ALAsset objects.
<br><br>

### TSAssetsPickerControllerDataSource
Data source has plenty of methods that are used to configure TAssetsPickerController. Things which you can configure with data source are: **number of items to select**, **filter** (`TSFilter` described later), **layout for assets view in selected orientation**, **look of activity indicators** when fetching and finish picking assets, **title of albums view**, **title of cancel button**, **title of select button**, **text of cell's label which is visible when no albums is available**, **reversed or normal order of albums/assets**, **determine if empty albums should be showed**, and if should be, **if picker should dimm title of cell which point on empty album**.

Last but not least is method you should use to **set subclasses for classes which you can customize**.
<br><br>


#### Classes to subclass
Following table describes clases which you can subclass.

| Class name | Description |
| :---------- | :----------- |
| `AlbumCell` | Base class of cel which is displayed of `TSAlbumsViewController` - cell with album name. |
| `NoAlbumsCell` | Base class of cell which is displayed on `TSAlbumsViewController` when there is no albums to display. |
| `AssetsCollectionViewLayout` | Base class of collection layout view used in `TSAssetsViewController` |
| `AssetsCollectionView` | Base class of `UICollectionView` used in `TSAssetsViewController`. |


### `TSFilter` and `TSSizePredicate`
`TSFilter` is used by `TSAssetsPickerControllerDataSource` in method `- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker`. Instance of this class determines what sort of assets and whith which options assets should be filtered. It's very simple to use. 

Instance may be created with filter (`Photo`, `Video`, `All`) and (optional) with one or more predicates.

Filter type is used to set if TSAssetsPickerController should shows only photos, videos or both of them. 

Filter can also takes `TSSizePredicate` object which determines which assets of which sizes should be visible. 

<br>
`TSSizePredicate` can match:

- if assets is equal to size,
- if assets is equal to one of few sizes,
- if assets size is less (or equal) than declared size,
- if assets size is greater (or equal) than declared size,

The most extensive designed initializer has ability to set logic gate. It is used to set more specific filters. You can set filter which accepts assets which are **less than 512x512 AND greater than 256x256**, or you can create filter which accepts assets **less than 512x512 OR greater than 1024x1024**. With simpler predicate you can set that picker should only accepts assets looks like screenshots by setting predicate which match array of sizes e.g. **640x1136, 1136x640, 640x960, 960x640**, etc. There is plenty of posibilites to set filter.

`TSSizePredicate` accepts array of CGSize objects contained in NSValue objects. TSSizePredicate share macro `TSSizeValue(width,height)`.
<br><br>

# Examples
Creating `TSAssetsPickerControllerInstnce`.

```objective-c
    _picker = [TSAssetsPickerController new];
    _picker.delegate = self;
    _picker.dataSource = self;
```
To responds to actions performed by picker class must implements few picker delegate's methods.

```objective-c
	   #pragma mark - TSAssetsPickerControllerDelegate
	   - (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
	       [_picker dismissViewControllerAnimated:YES completion:nil];
	   }
	
	   - (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
	       [_picker dismissViewControllerAnimated:YES completion:nil];
	       [DummyAssetsImporter importAssets:assets]; // Here is some class which gets data from ALAssets objects pass into.
	   }
	
	   - (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
	       if (error) {
	           NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
	       }
	   }
```
Two methods of picker's data source have to be also implemented.
```objective-c
    - (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
        return 3;
    }

    - (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
        TSSizePredicate *predicate = [TSSizePredicate matchSize:CGSizeMake(320, 480)];
        return [TSFilter filterWithType:FilterTypePhoto predicate:predicate];
    }
```
Setting layout for appropriate orientations:
```objective-c
	- (UICollectioftnViewLayout *)assetsPickerController:(TSAssetsPickerController *)picker needsLayoutForOrientation:(UIInterfaceOrientation)orientation {
	    AssetsCollectionViewLayout *layout = [AssetsCollectionViewLayout new];
	    if (UIInterfaceOrientationIsPortrait(orientation)) {
	        if (IS_IPHONE) {
	            [layout setItemSize:CGSizeMake(47, 47)];
	            [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
	            [layout setInternItemSpacingY:4.0f];
	            [layout setNumberOfColumns:6];
	        } else {
	            [layout setItemSize:CGSizeMake(115, 115)];
	            [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
	            [layout setInternItemSpacingY:10.0f];
	            [layout setNumberOfColumns:6];
	        }
	    } else {
	        if (IS_IPHONE) {
	            CGSize itemSize = CGSizeMake(48, 48);
	            if (IS_IPHONE_5) {
	                itemSize = CGSizeMake(45, 45);
	            }
	            [layout setItemSize:itemSize];
	            [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
	            [layout setInternItemSpacingY:4.0f];
	            
	            NSUInteger columns = IS_IPHONE_5 ? 11 : 9;
	            [layout setNumberOfColumns:columns];
	        } else {
	            [layout setItemSize:CGSizeMake(115, 115)];
	            [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
	            [layout setInternItemSpacingY:10.0f];
	            [layout setNumberOfColumns:8];
	        }
	    }
	    
	    return layout;
	}
```
`UIActivityIndicatorView` for both albums and assets views which is visible when picker is fetching data and when is finish picking. 
```objective-c
	- (UIActivityIndicatorView *)assetsPickerController:(TSAssetsPickerController *)picker activityIndicatorViewForPlaceIn:(ViewPlace)place {
	    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	    [indicatorView setColor:[UIColor redColor]];
	    [indicatorView setHidesWhenStopped:YES];
	    return indicatorView;
	}
```

Other optional methods of data source.
```objective-c
    - (NSString *)assetsPickerControllerTitleForAlbumsView:(TSAssetsPickerController *)picker {
	    return @"Albums";
    }
	
    - (NSString *)assetsPickerControllerTitleForCancelButtonInAlbumsView:(TSAssetsPickerController *)picker {
        return @"Cancel";
    }
	
    - (NSString *)assetsPickerControllerTitleForSelectButtonInAssetsView:(TSAssetsPickerController *)picker {
	    return @"Select";
    }
	
    - (NSString *)assetsPickerControllerTextForCellWhenNoAlbumsAvailable:(TSAssetsPickerController *)picker {
	    return @"Can't find any asset. Create some and back.";
    }
	
    - (BOOL)assetsPickerControllerShouldShowEmptyAlbums:(TSAssetsPickerController *)picker {
	    return YES;
    }
	
    - (BOOL)assetsPickerControllerShouldDimmCellsForEmptyAlbums:(TSAssetsPickerController *)picker {
        return NO;
    }
	
    - (BOOL)assetsPickerControllerShouldReverseAlbumsOrder:(TSAssetsPickerController *)picker {
	    return YES;
    }
```

# Requirements
`TSAssetsPickerController` needs ARC and works only on iOS6 and iOS7.
<br><br>
# Instalation
To install and use `TSAssetsPickerController` you have to add `Classes` directory to your project. If it's not from [CocoaPods](http://cocoapods.org) there should be three folders inside: `Controllers`, `Customizable Classes` and `API Classes`. After that you need import `TSAssetsPickerController`. It imports all needed to work classes.

    #import "TSAssetsPickerController.h"
    

### via CocoaPods
`TSAssetsPickerControlller` is also available on [CocoaPods](http://cocoapods.org).

    pod 'TSAssetsPickerController'


# Donate [![image](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=szulc%2etomasz%40o2%2epl&lc=US&item_name=Donate%20for%20TSAssetsPickerController&item_number=TSAssetsPickerController&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted)

If you like the project, you can donate it  :)
<br><br>

# Changelog
##### 1.2 (02.03.2014)
- `UICollectionFlowLayout` replaced with `UICollectionViewLayout`. Now setting layout is available via data source of `TSAssetsPickerController`.
- Added customizable activity indicators during fetching albums and assets and when picker is finish picking.
- Fixed wrong height of `UICollectionView` in `TSAssetsViewController` on iOS 6.
- AssetCell's `thumbnailImageView` and `movieMarkImageView` now are updating layout correctly.
- Improved performance during scrolling and loading 1000+ assets.

##### 1.1 (27.02.2014)
- Added `TSFilter` to filter assets before showing it to the user.
- Properties of `TSAssetsPickerController` have been moved to data source.
- Fixed reversing albums list.

##### 1.0.2 (23.02.2014)
- Added Podspec of `TSAssetsPickerController`. Now available on [CocoaPods](http://cocoapods.org)

##### 1.0.1 (23.02.2014)
- Added rotation support

##### 1.0 (22.02.2014)
- Implemented basic functionality
- Added to github
<br><br>

# License

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
