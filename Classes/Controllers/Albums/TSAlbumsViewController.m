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
#import "CenterLabeledCell.h"
#import "TSAlbumsLoader.h"
#import "TSAssetsViewController.h"

@implementation TSAlbumsViewController {
    TSAlbumsLoader *_albumLoader;
    
    NSString *_selectedAlbumName;
    NSMutableArray *_albums;
    
    BOOL _fetchedFirstTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _albumLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:[ALAssetsFilter allAssets]];
    _albums = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _selectedAlbumName = nil;
    [self fetchAlbums];
}

- (void)fetchAlbums {
    _fetchedFirstTime = NO;
    [_albums removeAllObjects];
    [_tableView reloadData];
    
    [_albumLoader fetchAlbumNames:^(NSString *albumName) {
        _fetchedFirstTime = YES;
        if (albumName) {
            [_albums addObject:albumName];
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
    return _albums.count ? : 1;
}

static NSString *cellIdentifier = nil;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = nil;
    if (_albums.count) {
        cellIdentifier = NSStringFromClass([AlbumCell class]);
        AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = _albums.reverseObjectEnumerator.allObjects[indexPath.row];
        _cell = cell;
    } else {
        CenterLabeledCell *cell = (CenterLabeledCell *)[tableView dequeueReusableCellWithIdentifier:@"NoAlbumsCell"];
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
    _selectedAlbumName = _albums.reverseObjectEnumerator.allObjects[indexPath.row];
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
