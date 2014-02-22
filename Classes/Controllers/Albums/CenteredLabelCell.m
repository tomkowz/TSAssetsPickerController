//
//  CenterLabeledCell.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 05.01.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "CenteredLabelCell.h"

@implementation CenteredLabelCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    CGFloat offset = 20.0;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(offset, 11, 100, 21)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:_label];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = [self margin];
    CGRect frame = _label.frame;
    frame.size.width = CGRectGetWidth(self.frame) - (2 * margin);
    _label.frame = frame;
    _label.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (CGFloat)margin {
    return 20.0;
}

@end
