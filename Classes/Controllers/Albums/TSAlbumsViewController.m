//
//  TSAlbumsViewController.m
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAlbumsViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "AlbumCell.h"
#import "CenteredLabelCell.h"
#import "TSAlbumsLoader.h"
#import "TSAssetsViewController.h"

@implementation TSAlbumsViewController {
    TSAlbumsLoader *_albumsLoader;
    
    NSString *_selectedAlbumName;
    
    BOOL _fetchedFirstTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _albumsLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:[ALAssetsFilter allAssets]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _selectedAlbumName = nil;
    [self fetchAlbums];
}

- (void)fetchAlbums {
    _fetchedFirstTime = NO;
    
    [_albumsLoader fetchAlbumNames:^(NSArray *albumNames) {
        _fetchedFirstTime = YES;
        if (albumNames) {
            [_tableView reloadData];
        } else {
            // Something goes really wrong during fetch.
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumsLoader.fetchedAlbumNames.count ? : 1;
}

static NSString *cellIdentifier = nil;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = nil;
    if (_albumsLoader.fetchedAlbumNames.count > 0) {
        cellIdentifier = NSStringFromClass([AlbumCell class]);
        AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = _albumsLoader.fetchedAlbumNames.reverseObjectEnumerator.allObjects[indexPath.row];
        _cell = cell;
    } else {
        CenteredLabelCell *cell = (CenteredLabelCell *)[tableView dequeueReusableCellWithIdentifier:@"NoAlbumsCell"];
        if (_fetchedFirstTime) {
            cell.label.text = @"No albums. Make some photos";
        } else {
            cell.label.text = @"";
        }
        _cell = cell;
    }
    return _cell;
}


#pragma mark - UITableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedAlbumName = _albumsLoader.fetchedAlbumNames.reverseObjectEnumerator.allObjects[indexPath.row];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Segue Support
static NSString *const kToImagesSegue = @"Assets";
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToImagesSegue]) {
        TSAssetsViewController *destination = (TSAssetsViewController *)segue.destinationViewController;
        [destination configureWithAlbumName:_selectedAlbumName];
    }
}


@end
