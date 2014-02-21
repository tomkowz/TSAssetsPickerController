TSAssetsPickerController
========================

TSAssetPickerController is a custom picker controller which allows you to select multiple assets from Photos app on iOS.

I decided to share this picker because it's easy to add to the project, easy to maintain and it works very well. This picker is used by [iWrapper app](https://itunes.apple.com/pl/app/iwrapper-superb-screenshots/id549973157?mt=8). Try it and apply to your projects.


Why should I use it?
========================
Why should you write the same controller from scratch? :)


What it can do?
========================
This picker allows you to select multiple (defined by you) assets and do what you want with them. In the example code there is connected DummyAssetsImporter which simulate assets importing, but you may do whatever you want.


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


TSAlbumsViewController is a list of available albums fetched from Photos app. It is represented as cells in UITableView and uses TSAlbumsLoader. 

TSAssetsViewController is a controller which display assets from selected album. It has UICollectionView and uses TSAssetsManager. 


About classes
=========================
TSBaseLoader - it is base class for TSAlbumsLoader and TSAssetsLoader. It keeps reference to ALAssetsLibrary which is needed to work with ALAssets objects, and also it keeps information about which filter should be use when browsing albums and assets.

TSAlbumsLoader - the same as above, can fetch album names.

TSAssetsLoader - the same as TSBaseLoader, can fetch assets from selected album.

TSAssetsContainer - This class is container which can store and manage ALAssets objects. It is used by TSAssetsManager class.

TSAssetsManager - This classes is used directly by TSAssetsViewController. Instance is initialized with TSAssetsLoader object. It keeps information about fetched and selected assets. It can fetch assets via TSAssetsLoader. Also it can mark assets as selected or deselected and check if asset exists.

In View Controllers only TSAlbumsLoader and TSAssetsManager is important. 

How to install
=========================
1) checkout repo

2) add files from /Classes directory to your project

3) open Main.storyboard file and copy TSAlbumsViewController and TSAssetsViewController

4) add AssetsLibrary.framework

Remember to do it in the same order. After copy-paste view controllers from storyboard all connections will be the same (no missing connections).

