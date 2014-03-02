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
#import "AlbumsTableView.h"
#import "NoAlbumsCell.h"
#import "SystemVersionMacros.h"
#import "TSAlbumsLoader.h"
#import "TSAssetsPickerController.h"
#import "TSAssetsPickerController+Internals.h"
#import "TSAssetsViewController.h"

@interface TSAlbumsViewController ()  <UITableViewDelegate, UITableViewDataSource, TSAssetsViewControllerDelegate> {
    TSAlbumsLoader *_albumsLoader;
    BOOL _fetchedFirstTime;
    UIActivityIndicatorView *_indicatorView;
}

@end

@implementation TSAlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _configureAlbumsLoader];
    self.title = _picker.albumsViewControllerTitle;
    [self _configureNavigationBarButtons];
    [self _setupViews];
    [self _addActivityIndicatorToNavigationBar];
}

- (void)_addActivityIndicatorToNavigationBar {
    if (!_indicatorView) {
        _indicatorView = [_picker activityIndicatorViewForPlaceIn:AlbumsView];
        UIBarButtonItem *itemIndicator = [[UIBarButtonItem alloc] initWithCustomView:_indicatorView];
        [self.navigationItem setRightBarButtonItem:itemIndicator];
    }
}

#pragma mark - Configuration
- (void)_configureAlbumsLoader {
    TSFilter *filter = [_picker.dataSource filterOfAssetsPickerController:_picker];
    _albumsLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:filter];
    _albumsLoader.shouldReverseOrder = _picker.shouldReverseAlbumsOrder;
    _albumsLoader.shouldReturnEmptyAlbums = _picker.shouldShowEmptyAlbums;
}

- (void)_setupViews {
    _tableView = [self newTableView];
    [self.view addSubview:_tableView];
}

- (void)_configureNavigationBarButtons {
    UIBarButtonItem *cancelButton =
    [[UIBarButtonItem alloc] initWithTitle:_picker.cancelButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(onCancelPressed)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

- (UITableView *)newTableView {
    CGRect frame = self.view.bounds;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        frame.size.height -= CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    Class subclassOfTableViewClass = [_picker subclassForClass:[AlbumsTableView class]];
    UITableView *tableView = [[subclassOfTableViewClass alloc] initWithFrame:frame style:UITableViewStylePlain];
    [tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
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

    [_indicatorView startAnimating];
    
    [_albumsLoader fetchAlbumNames:^(NSArray *albumNames, NSError *error) {
        _fetchedFirstTime = YES;
        [_indicatorView stopAnimating];
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

    if (showAlbumCell) {
        Class class = [_picker subclassForClass:[AlbumCell class]];
        id cell = [class new];
        
        AlbumRepresentation *albumRepresentation = _albumsLoader.fetchedAlbumRepresentations[indexPath.row];
        [(UILabel *)[cell valueForKey:@"textLabel"] setText:albumRepresentation.name];

        if (_picker.shouldDimmEmptyAlbums)
            [cell dimm:albumRepresentation.isEmpty];
        
        _cell = cell;
    } else {
        Class class = [_picker subclassForClass:[NoAlbumsCell class]];
        id cell = [class new];
        if (_fetchedFirstTime) {
            [(UILabel *)[cell valueForKey:@"label"] setText: _picker.noAlbumsForSelectedFilter];
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
