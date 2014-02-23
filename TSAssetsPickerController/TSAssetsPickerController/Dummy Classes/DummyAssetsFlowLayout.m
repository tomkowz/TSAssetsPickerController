//
//  DummyAssetsFlowLayout.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 23.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyAssetsFlowLayout.h"

@implementation DummyAssetsFlowLayout

- (UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionHorizontal;
}

- (CGFloat)minimumLineSpacing {
    return 10.0;
}

- (CGFloat)minimumInteritemSpacing {
    return 0.0;
}

- (UIEdgeInsets)sectionInset {
    return UIEdgeInsetsMake(4, 4, 4, 4);
}

@end
