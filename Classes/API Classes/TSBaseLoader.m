//
//  TSBaseLoader.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSBaseLoader.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TSFilter.h"

@implementation TSBaseLoader

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(TSFilter *)filter {
    NSParameterAssert(library);
    NSParameterAssert(filter);
    
    self = [super init];
    if (self) {
        _library = library;
        _filter = filter;
        _shouldReverseOrder = YES;
    }
    return self;
}

@end
