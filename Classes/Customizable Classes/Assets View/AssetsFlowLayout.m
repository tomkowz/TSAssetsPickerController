//
//  AssetsFlowLayout.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 23.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AssetsFlowLayout.h"

@implementation AssetsFlowLayout

#pragma mark - initialization
- (instancetype)initWithItemSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.itemSize = size;
    }
    return self;
}

- (UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionVertical;
}

- (CGFloat)minimumLineSpacing {
    return 4.0;
}

- (CGFloat)minimumInteritemSpacing {
    return 0.0;
}

- (UIEdgeInsets)sectionInset {
    return UIEdgeInsetsMake(4, 4, 4, 4);
}

@end
