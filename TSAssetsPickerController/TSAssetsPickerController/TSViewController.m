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
    }

    [self presentViewController:_picker animated:YES completion:nil];
}


#pragma mark - TSAssetsPickerControllerDataSource


- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
    return 3;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
    TSSizePredicate *predicate = [TSSizePredicate matchSize:CGSizeMake(320, 480)];
    return [TSFilter filterWithType:FilterTypePhoto predicate:predicate];
}

/*
- (NSString *)assetsPickerControllerTitleForAlbumsView:(TSAssetsPickerController *)picker {
    return @"Albums1";
}

- (NSString *)assetsPickerControllerTitleForCancelButtonInAlbumsView:(TSAssetsPickerController *)picker {
    return @"Cancel1";
}

- (NSString *)assetsPickerControllerTitleForSelectButtonInAssetsView:(TSAssetsPickerController *)picker {
    return @"Select1";
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
}*/

#pragma mark - TSAssetsPickerControllerDelegate
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    [_picker dismissViewControllerAnimated:YES completion:nil];
    [DummyAssetsImporter importAssets:assets];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
    }
}

@end
