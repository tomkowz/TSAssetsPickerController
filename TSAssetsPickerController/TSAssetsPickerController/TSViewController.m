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

    [DummyAssetsImporter importAssets:assets];
}

@end
