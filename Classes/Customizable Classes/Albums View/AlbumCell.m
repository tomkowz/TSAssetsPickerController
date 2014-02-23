//
//  AblumCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (id)init {
    self = [super init];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)dimm:(BOOL)dimm {
    CGFloat alpha = dimm ? 0.3 : 1.0;
    self.textLabel.alpha = alpha;
}

@end
