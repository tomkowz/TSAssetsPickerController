//
//  AblumCell.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumRepresentation;

@interface AlbumCell : UITableViewCell
- (void)configureWithAlbumRepresentation:(AlbumRepresentation *)albumRepresentation dimmIfEmpty:(BOOL)dimm;
@end
