//
//  TSViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSViewController.h"

#import "TSAssetsPickerController.h"

#import "DummyAssetsImporter.h"
#import "DummyAlbumCell.h"
#import "DummyNoAlbumsCell.h"
#import "DummyAlbumsTableView.h"
#import "DummyAssetCell.h"
#import "DummyAssetsFlowLayout.h"
#import "DummyAssetsCollectionView.h"

@interface TSViewController () <TSAssetsPickerControllerDelegate, TSAssetsPickerControllerDataSource, UINavigationControllerDelegate> {
    TSAssetsPickerController *_picker;
}
@end

@implementation TSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didEndImportAssets {
    [self.navigationController popToViewController:self animated:YES];
    NSLog(@"Done");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onOpenPickerPressed:(id)sender {
    if (!_picker) {
        _picker = [TSAssetsPickerController new];
        _picker.delegate = self;
        _picker.dataSource = self;
        // Main configuration
        
//        _picker.albumsViewControllerTitle = @"Albumy";
//        _picker.selectButtonTitle = @"Wybierz";
//        _picker.cancelButtonTitle = @"Anuluj";
        
        _picker.noAlbumsForSelectedFilter = @"Can't find any asset. Create some and back.";
        
        _picker.shouldReverseAlbumsOrder = NO;
        _picker.shouldReverseAssetsOrder = YES;
        
        _picker.shouldShowEmptyAlbums = NO;
        _picker.shouldDimmEmptyAlbums = NO;
    }

    [self presentViewController:_picker animated:YES completion:nil];
}


#pragma mark - TSAssetsPickerControllerDataSource
- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
    return 3;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
    
    TSFilter *filter = [TSFilter filterWithType:FilterTypePhoto];
    /*
    /// Specify size of assets
//    NSArray *screenshotSizes = @[TSSizeValue(320, 480), TSSizeValue(1136, 640)];

    /// Create descriptor
//    TSDescriptor *equalDescriptor = [TSDescriptor descriptorWithDimensionsEqualToSizes:screenshotSizes];
    TSSizePredicate *lessDescriptor = [TSSizePredicate matchSizeLessThan:CGSizeMake(1136, 640) orEqual:YES];
    TSSizePredicate *greaterDescriptor = [TSSizePredicate matchSizeGreaterThan:CGSizeMake(320, 480) orEqual:YES];
    TSFilter *filter = [TSFilter filterWithType:FilterTypePhoto predicates:@[lessDescriptor, greaterDescriptor] logicGateType:AND];
    */
    return filter;
}

/*
- (Class)assetsPickerController:(TSAssetsPickerController *)picker subclassForClass:(Class)aClass {
    Class c = nil;
    // Custom classes should be set by data source method.
    if (aClass == [AlbumCell class])
        c = [DummyAlbumCell class];
    
    if (aClass == [AlbumsTableView class])
        c = [DummyAlbumsTableView class];
    
    if (aClass == [AssetCell class])
        c = [DummyAssetCell class];
    
    return c;
}
*/

#pragma mark - TSAssetsPickerControllerDelegate
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    /*
     Do something here with assets.
     Here for example DummyAssetsImporter "imports" data from assets and make some log.
     */
    [_picker dismissViewControllerAnimated:YES completion:nil];
    [DummyAssetsImporter importAssets:assets];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
    }
}

@end
