//
//  TSBaseLoader.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ALAssetsLibrary, ALAssetsFilter;

@interface TSBaseLoader : NSObject
@property (nonatomic, readonly) ALAssetsLibrary *library;
@property (nonatomic, readonly) ALAssetsFilter *filter;

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(ALAssetsFilter *)filter;

@end
