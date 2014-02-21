//
//  TSBaseLoader.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSBaseLoader.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation TSBaseLoader

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter {
    NSParameterAssert(library);
    NSParameterAssert(filter);
    
    self = [super init];
    if (self) {
        _library = library;
        _filter = filter;
    }
    return self;
}

@end
