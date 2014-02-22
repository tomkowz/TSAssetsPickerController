TSAssetsPickerController
========================
<p>&nbsp;</p>
<p><p align="center"><img src="https://raw.github.com/tomkowz/TSAssetsPickerController/master/docs/demo.gif"/></p></p>



TSAssetPickerController is a custom picker controller which allows you to select multiple assets from Camera Roll.

I decided to share this picker because it's easy to add to the project, easy to maintain and it works very well. This picker is used by [iWrapper app](https://itunes.apple.com/pl/app/iwrapper-superb-screenshots/id549973157?mt=8). Try it and apply to your projects.


Why should You use it?
========================
Why should you write the same controller from scratch? :)


What it can do?
========================
This picker allows you to select multiple (defined by you) assets and do what you want with them. In the example code there is connected DummyAssetsImporter which simulate assets importing, but you may do whatever you want.

It supports photo and video assets. Video assets has thumbnail with little "play" mark. 

- Browse all albums
- Set filters (only Photos, only Videos, All)
- Select multiple assets from one album
- Customizable order of displaying assets, last-first, first-first (iWrapper has last-first, it cause that user can't scroll 1000+ elements to get latest asset)
- Other configurations, looks below
- Easy to apply in your project
- Easy to customize


Configuration
========================
`TSAssetsPickerController` class has `TSAssetsPickerControllerConfiguration` property which is used to keep settings for the picker.
| Property                      | Type           	| Default value |
| ----------------------------- | -----------------	| -------------:|
| numberOfItemsToSelect			| `NSUInteger`		| 1				|
| filter						| `ALAssetsFilter`	| allPhotos		|
| noAlbumsForSelectedFilter		| `NSString`		| some string	|
| shouldReverseAlbumsOrder		| `BOOL`			| YES			|
| shouldReverseAssetsOrder		| `BOOL`			| YES			|
| shouldShowEmptyAlbums			| `BOOL`			| NO			|
| shouldDimmEmptyAlbums			| `BOOL`			| YES			|



How it works?
========================

It consists of two parts:
- API
- View Controllers


API
=========================
![image](https://github.com/tomkowz/TSAssetsPickerController/blob/master/docs/diag1.png?raw=true)


View Controllers
=========================
![image](https://github.com/tomkowz/TSAssetsPickerController/blob/master/docs/diag2.png?raw=true)


About classes
=========================

`TSAssetsPickerController` - This is a picker controller. You present this controller if you want to show picker on the screen. This class has `TSAssetsPickerControllerConfiguration` property and delegates your class should conforms to.

`TSAssetsPickerControllerConfiguration` - This class keeps picker's settings.


Not important for you but you can read about "low-level" classes:

`TSBaseLoader` with `ALAssets` objects, and also it keeps information about which filter should be use when browsing albums and assets.

`TSAlbumsLoader` - the same as above, can fetch album names.

`TSAssetsLoader` - the same as `TSBaseLoader`, can fetch assets from selected album.

`TSAssetsContainer` - This class is container which can store and manage ALAssets objects. It is used by `TSAssetsManager` class.

`TSAssetsManager` - This classes is used directly by `TSAssetsViewController`. Instance is initialized with `TSAssetsLoader` object. It keeps information about fetched and selected assets. It can fetch assets via `TSAssetsLoader`. Also it can mark assets as selected or deselected and check if asset exists.

`AlbumRepresentation` - This class represents album.

How to use
=========================
1. Import /Classes directory to your project
2. Write some init code

````objc
- (IBAction)onOpenPickerPressed:(id)sender {
    if (!_picker) {
        _picker = [TSAssetsPickerController new];
        _picker.delegate = self;
        _picker.configuration.numberOfItemsToSelect = 3;
        
        _picker.configuration.filter = [ALAssetsFilter allVideos];
        _picker.configuration.noAlbumsForSelectedFilter = @"Can't find any video. Record some and back.";
        
        _picker.configuration.shouldReverseAlbumsOrder = NO;
        _picker.configuration.shouldReverseAssetsOrder = YES;
        
//        _picker.configuration.shouldShowEmptyAlbums = YES;
//        _picker.configuration.shouldDimmEmptyAlbums = NO;
    }

    [self presentViewController:_picker animated:YES completion:nil];
}
````
