//
//  CenterLabeledCell.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoAlbumsCell : UITableViewCell
@property (nonatomic) UILabel *label;

/*
 Called during initialization, override to setup label
 Also override layoutSubview if you want custom view positioning
 */
- (void)setup;

@end
