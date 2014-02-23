//
//  AssetsCollectionView.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 23.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetsCollectionView.h"

@implementation AssetsCollectionView

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [self setBounces:YES];
    [self setScrollEnabled:YES];
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

@end
