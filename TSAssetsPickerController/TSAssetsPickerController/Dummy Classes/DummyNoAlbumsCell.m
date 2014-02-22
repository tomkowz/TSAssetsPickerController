//
//  DummyNoAlbumsCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 22.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "DummyNoAlbumsCell.h"

@implementation DummyNoAlbumsCell

- (UILabel *)label {
    UILabel *label = [super label];
    label.font = [UIFont systemFontOfSize:10.0];
    label.textColor = [UIColor blueColor];
    self.label = label;
    
    return label;
}


@end
