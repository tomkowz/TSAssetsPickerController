//
//  AblumCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AlbumCell.h"

#import "AlbumRepresentation.h"

@implementation AlbumCell

- (void)configureWithAlbumRepresentation:(AlbumRepresentation *)albumRepresentation dimmIfEmpty:(BOOL)dimm {
    self.textLabel.text = albumRepresentation.name;
    
    if (dimm) {
        CGFloat alpha = albumRepresentation.isEmpty ? 0.3 : 1.0;
        self.textLabel.alpha = alpha;
    }
}

@end
