//
//  TSAlbumLoader.h
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSBaseLoader.h"

@interface TSAlbumsLoader : TSBaseLoader

- (void)fetchAlbumNames:(void (^)(NSString *albumName))block;

@end
