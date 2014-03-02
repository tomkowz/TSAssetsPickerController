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
#import "DummyAssetsCollectionView.h"
#import "AssetsCollectionViewLayout.h"
#import "DeviceTypesMacros.h"

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
    return [TSFilter filterWithType:FilterTypeAll];
}

/*
- (UIActivityIndicatorView *)assetsPickerController:(TSAssetsPickerController *)picker activityIndicatorViewForPlace:(ViewPlace)place {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setColor:[UIColor redColor]];
    [indicatorView setHidesWhenStopped:YES];
    return indicatorView;
}

- (UICollectionViewLayout *)assetsPickerController:(TSAssetsPickerController *)picker needsLayoutForOrientation:(UIInterfaceOrientation)orientation {
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
}
*/

#pragma mark - TSAssetsPickerControllerDelegate
- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_picker dismissViewControllerAnimated:YES completion:nil];
        [DummyAssetsImporter importAssets:assets];
    });
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
    }
}

@end
