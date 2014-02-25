//
//  TSAssetsPickerController+Subclasses.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController+Subclasses.h"
#import "TSAssetsPickerController.h"
@implementation TSAssetsPickerController (Subclasses)

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
