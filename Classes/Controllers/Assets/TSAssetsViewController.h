//
//  TSAssetsViewController.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *DidEndImportAssetsNotification;

@interface TSAssetsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (void)configureWithAlbumName:(NSString *)name;
- (IBAction)onSelectPressed:(id)sender;

@end
