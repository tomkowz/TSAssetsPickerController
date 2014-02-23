//
//  DummyAlbumCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyAlbumCell.h"

@implementation DummyAlbumCell

- (id)init {
    self = [super init];
    if (self) {
        self.textLabel.textColor = [UIColor greenColor];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

@end
