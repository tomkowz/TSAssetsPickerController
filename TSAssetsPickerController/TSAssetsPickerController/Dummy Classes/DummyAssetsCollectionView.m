//
//  DummyAssetsCollectionView.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 23.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyAssetsCollectionView.h"

@implementation DummyAssetsCollectionView

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [self setBounces:YES];
    [self setScrollEnabled:YES];
    
    [self setBackgroundColor:[UIColor yellowColor]];
}

@end
