//
//  TSAlbumLoader.h
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSBaseLoader.h"

@interface TSAlbumsLoader : TSBaseLoader
@property (nonatomic, readonly) NSArray *fetchedAlbumRepresentations;
@property (nonatomic) BOOL shouldReturnEmptyAlbums; // default set to NO

- (void)fetchAlbumNames:(void (^)(NSArray *albumNames, NSError *error))block;

@end
