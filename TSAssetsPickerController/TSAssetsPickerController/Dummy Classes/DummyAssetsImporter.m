//
//  DummyAssetsImporter.m
//  TSImagePickerController
//
//  Created by Tomasz Szulc on 21.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyAssetsImporter.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation DummyAssetsImporter

+ (BOOL)importAssets:(NSArray *)assets {
    BOOL success = YES;
    for (ALAsset *asset in assets) {
        NSLog(@"Asset: %@", asset);
        
        // Data prepared to store
        NSData *data = [self dataRepresentationOfAsset:asset];
        NSLog(@"Prepared %d bytes to save. Should I do something with this?", (int)[data length]);
        
        // Here your logic how-to deal with this data...
        // ...
    }
    NSLog(@"---");
    NSLog(@"Done");
    return success;
}

+ (NSData *)dataRepresentationOfAsset:(ALAsset *)asset {
    ALAssetRepresentation *representation = [asset defaultRepresentation];
    Byte *buffer = (Byte*)malloc((unsigned long)representation.size);
    NSError *error = nil;
    NSUInteger buffered = [representation getBytes:buffer fromOffset:0.0 length:(unsigned long)representation.size error:&error];
    return [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
}

@end
