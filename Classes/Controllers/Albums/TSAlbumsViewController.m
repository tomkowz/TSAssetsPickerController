//
//  TSAlbumsViewController.m
//  TSAssetsPickerController
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

@interface TSAlbumsViewController ()  <UITableViewDelegate, UITableViewDataSource> {
    TSAlbumsLoader *_albumsLoader;
    NSString *_selectedAlbumName;
    BOOL _fetchedFirstTime;
}

@end

@implementation TSAlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    _albumsLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:[ALAssetsFilter allAssets]];
}

- (void)setupViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
#warning add support when user block photos
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = nil;
    BOOL showAlbumCell = _albumsLoader.fetchedAlbumNames.count > 0;
    Class cellClass =  showAlbumCell ? [AlbumCell class] : [CenteredLabelCell class];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cellClass) owner:self options:nil];

    if (showAlbumCell ) {
        AlbumCell *cell = (AlbumCell *)[topLevelObjects objectAtIndex:0];
#warning Add ability to reverse order of this loader. Move this property to loader class
        cell.textLabel.text = _albumsLoader.fetchedAlbumNames.reverseObjectEnumerator.allObjects[indexPath.row];
        _cell = cell;
    } else {
        CenteredLabelCell *cell = (CenteredLabelCell *)[topLevelObjects objectAtIndex:0];
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
