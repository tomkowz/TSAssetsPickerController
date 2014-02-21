//
//  TSAlbumsViewController.h
//  TSAssetPickerController
//
//  Created by Tomasz Szulc on 11.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSAlbumsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
