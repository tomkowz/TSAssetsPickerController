//
//  TSAlbumsViewController.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAlbumsViewController.h"

#import "TSAssetsPickerController.h"

#import "AlbumCell.h"
#import "CenteredLabelCell.h"
#import "TSAlbumsLoader.h"
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
    _albumsLoader = [[TSAlbumsLoader alloc] initWithLibrary:[ALAssetsLibrary new] filter:[ALAssetsFilter allAssets]];
//    _albumsLoader.shouldReverseOrder = NO;
}

- (void)_setupViews {
    _tableView = [self newTableView];
    [self.view addSubview:_tableView];
}

- (void)_configureNavigationBarButtons {
    UIBarButtonItem *cancelButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancelPressed)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

- (UITableView *)newTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    return _albumsLoader.fetchedAlbumNames.count ? : 1;
}

static NSString *const toAssetSegue = @"ToAssets";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell = nil;
    BOOL showAlbumCell = _albumsLoader.fetchedAlbumNames.count > 0;
    Class cellClass =  showAlbumCell ? [AlbumCell class] : [CenteredLabelCell class];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cellClass) owner:self options:nil];

    if (showAlbumCell ) {
        AlbumCell *cell = (AlbumCell *)[topLevelObjects objectAtIndex:0];
        cell.textLabel.text = _albumsLoader.fetchedAlbumNames[indexPath.row];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *albumName = _albumsLoader.fetchedAlbumNames[indexPath.row];
    [self _showAssetsViewControllerWithAlbumName:albumName];
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
