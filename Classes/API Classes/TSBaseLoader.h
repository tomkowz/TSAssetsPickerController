//
//  TSBaseLoader.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ALAssetsLibrary;
@class TSFilter;

@interface TSBaseLoader : NSObject
@property (nonatomic, readonly) ALAssetsLibrary *library;
@property (nonatomic, readonly) TSFilter *filter;
@property (nonatomic) BOOL shouldReverseOrder; // default YES

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library filter:(TSFilter *)filter;

@end
