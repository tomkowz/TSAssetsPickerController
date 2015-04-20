//
//  AlbumRepresentation.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "AlbumRepresentation.h"

@implementation AlbumRepresentation

+ (instancetype)albumRepresentationWithName:(NSString *)name thumbnail:(UIImage *)thumbnail isEmpty:(BOOL)empty {
    return [[AlbumRepresentation alloc] initWithAlbumName:name thumbnail:(UIImage *)thumbnail isEmpty:empty];
}

- (instancetype)initWithAlbumName:(NSString *)name thumbnail:(UIImage *)thumbnail isEmpty:(BOOL)empty {
    self = [super init];
    if (self) {
        _name = name;
        _thumbnail = thumbnail;
        _empty = empty;
    }
    return self;
}

@end
