//
//  TSViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSViewController.h"

#import "TSAssetsViewController.h"

@interface TSViewController ()

@end

@implementation TSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndImportAssets) name:DidEndImportAssetsNotification object:nil];
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

@end
