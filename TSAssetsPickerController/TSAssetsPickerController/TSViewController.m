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
#import "DummyNoAlbumsCell.h"

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
        _picker.configuration.numberOfItemsToSelect = 3;
        
        _picker.configuration.filter = [ALAssetsFilter allAssets];
        _picker.configuration.noAlbumsForSelectedFilter = @"Can't find any asset. Create some and back.";
        
        _picker.configuration.shouldReverseAlbumsOrder = NO;
        _picker.configuration.shouldReverseAssetsOrder = YES;
        
//        _picker.configuration.shouldShowEmptyAlbums = YES;
//        _picker.configuration.shouldDimmEmptyAlbums = NO;
        
        
        // Custom No Albums Cell which is visible when there is no albums in first view of TSAssetsPickerController
//        _picker.configuration.noAlbumCellClass = [DummyNoAlbumsCell class];
        
#warning replace this way of customizing with above one
        // Custom Asset Cell configuration
        /*
        [AssetCell setPreferedCellSize:CGSizeMake(50, 50)];
        [AssetCell setPreferedThumbnailRect:CGRectMake(5, 5, 40, 40)];
        [AssetCell setPreferedMovieMarkRect:CGRectMake(22, 22, 20, 20)];
        [AssetCell setPreferedImageForMovieMark:[UIImage imageNamed:@"movieMark"]];
        
        UIColor *normal = [UIColor colorWithWhite:0.7 alpha:0.3];
        [AssetCell setPreferedBackgroundColor:normal forState:Normal];
        
        UIColor *selected = [UIColor colorWithRed:21.0f/255.0f green:150.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
        [AssetCell setPreferedBackgroundColor:selected forState:Selected];
         */
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
