//
//  TSAlbumsViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAlbumsViewController.h"


#import "AlbumCell.h"
#import "AlbumRepresentation.h"
#import "NoAlbumsCell.h"
#import "SystemVersionMacros.h"
#import "TSAlbumsLoader.h"
#import "TSAssetsPickerController.h"
#import "TSAssetsViewController.h"

@interface TSAlbumsViewController ()  <UITableViewDelegate, UITableViewDataSource, TSAssetsViewControllerDelegate> {
    TSAlbumsLoader *_albumsLoader;
    BOOL _fetchedFirstTime;
}

@end

@implementation TSAlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _configureAlbumsLoader];

    [self _configureNavigationBarButtons];
    [self _setupViews];
}


#pragma mark - Configuration
- (void)_configureAlbumsLoader {
    _albumsLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:_picker.configuration.filter];
    _albumsLoader.shouldReverseOrder = _picker.configuration.shouldReverseAlbumsOrder;
    _albumsLoader.shouldReturnEmptyAlbums = _picker.configuration.shouldShowEmptyAlbums;
}

- (void)_setupViews {
    _tableView = [self newTableView];
    [self.view addSubview:_tableView];
}

- (void)_configureNavigationBarButtons {
    UIBarButtonItem *cancelButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelPressed)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

- (UITableView *)newTableView {
    CGRect frame = self.view.bounds;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        frame.size.height -= CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _fetchAlbums];
}


#pragma mark - Actions
- (void)onCancelPressed {
    [_delegate albumsViewControllerDidCancel:self];
}


#pragma mark - Fetch
- (void)_fetchAlbums {
    _fetchedFirstTime = NO;
    
    [_albumsLoader fetchAlbumNames:^(NSArray *albumNames, NSError *error) {
        _fetchedFirstTime = YES;
        
        if (!error) {
            [_tableView reloadData];
        } else {
            [_delegate albumsViewController:self failedWithError:error];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumsLoader.fetchedAlbumRepresentations.count ? : 1;
}

static NSString *const toAssetSegue = @"ToAssets";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = nil;
    BOOL showAlbumCell = _albumsLoader.fetchedAlbumRepresentations.count > 0;
    showAlbumCell = NO;

    if (showAlbumCell) {
        /*
        AlbumCell *cell = (AlbumCell *)[topLevelObjects objectAtIndex:0];
        AlbumRepresentation *albumRepresentation = _albumsLoader.fetchedAlbumRepresentations[indexPath.row];
        [cell configureWithAlbumRepresentation:albumRepresentation dimmIfEmpty:_picker.configuration.shouldDimmEmptyAlbums];
        _cell = cell;
         */
    } else {
        Class class = _picker.configuration.noAlbumCellClass;
        id cell = [class new];
        if (_fetchedFirstTime) {
            [(UILabel *)[cell valueForKey:@"label"] setText: _picker.configuration.noAlbumsForSelectedFilter];
        } else {
            [(UILabel *)[cell valueForKey:@"label"] setText:@""];
        }
        _cell = cell;
    }
    
    return _cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AlbumRepresentation *album = _albumsLoader.fetchedAlbumRepresentations[indexPath.row];
    [self _showAssetsViewControllerWithAlbumName:album.name];
}

- (void)_showAssetsViewControllerWithAlbumName:(NSString *)name {
    TSAssetsViewController *assetsVC = [TSAssetsViewController new];
    assetsVC.delegate = self;
    assetsVC.picker = _picker;
    [assetsVC configureWithAlbumName:name];
    [self.navigationController pushViewController:assetsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


#pragma mark - TSAssetsViewControllerDelegate
- (void)assetsViewController:(TSAssetsViewController *)assetsVC didFinishPickingAssets:(NSArray *)assets {
    [_delegate albumsViewController:self didFinishPickingAssets:assets];
}

- (void)assetsViewController:(TSAssetsViewController *)albumsVC {
    [_delegate albumsViewControllerDidCancel:self];
}

- (void)assetsViewController:(TSAssetsViewController *)albumsVC failedWithError:(NSError *)error {
    [_delegate albumsViewController:self failedWithError:error];
}

@end
