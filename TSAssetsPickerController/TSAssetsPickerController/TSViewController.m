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

@interface TSViewController () <TSAssetsPickerControllerDelegate, UINavigationControllerDelegate> {
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
        
        // Main configuration
        _picker.numberOfItemsToSelect = 3;
        
//        _picker.selectButtonTitle = @"Wybierz";
//        _picker.cancelButtonTitle = @"Anuluj";
        
        _picker.filter = [ALAssetsFilter allAssets];
        _picker.noAlbumsForSelectedFilter = @"Can't find any asset. Create some and back.";
        
        _picker.shouldReverseAlbumsOrder = NO;
        _picker.shouldReverseAssetsOrder = YES;
        
//        _picker.shouldShowEmptyAlbums = YES;
//        _picker.shouldDimmEmptyAlbums = NO;
        
        
        // Custom No Albums Cell which is visible when there is no albums in first view of TSAssetsPickerController
//        _picker.subclassOfAlbumCellClass = [DummyAlbumCell class];
//        _picker.subclassOfNoAlbumsCellClass = [DummyNoAlbumsCell class];
//        _picker.subclassOfAlbumsTableViewClass = [DummyAlbumsTableView class];
//        _picker.subclassOfAssetCellClass = [DummyAssetCell class];
//        _picker.subclassOfAssetsFlowLayoutClass = [DummyAssetsFlowLayout class];
//        _picker.subclassOfAssetsCollectionViewClass = [DummyAssetsCollectionView class];
    }

    [self presentViewController:_picker animated:YES completion:nil];
}


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
