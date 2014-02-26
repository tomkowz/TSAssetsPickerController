//
//  TSAssetsPickerController+Subclasses.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController+Internals.h"
#import "TSAssetsPickerController.h"


@implementation TSAssetsPickerController (Internals)

- (BOOL)shouldShowEmptyAlbums {
    BOOL should = NO;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldShowEmptyAlbums:)]) {
        should = [self.dataSource assetsPickerControllerShouldShowEmptyAlbums:self];
    }
    return should;
}

- (BOOL)shouldDimmEmptyAlbums {
    BOOL should = YES;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldDimmCellsForEmptyAlbums:)]) {
        should = [self.dataSource assetsPickerControllerShouldDimmCellsForEmptyAlbums:self];
    }
    return should;
}

- (Class)subclassForClass:(Class)aClass {
    Class subclass = aClass;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerController:subclassForClass:)]) {
        Class s = [self.dataSource assetsPickerController:self subclassForClass:aClass];
        if (s) {
            subclass = s;
        }
    }
    
    return subclass;
}

@end
