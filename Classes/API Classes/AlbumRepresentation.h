//
//  AlbumRepresentation.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumRepresentation : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

+ (instancetype)albumRepresentationWithName:(NSString *)name isEmpty:(BOOL)empty;

@end
