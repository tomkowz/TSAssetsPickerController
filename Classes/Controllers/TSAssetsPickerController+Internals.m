//
//  TSAssetsPickerController+Subclasses.m
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 25.02.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#import "TSAssetsPickerController+Internals.h"
#import "TSAssetsPickerController.h"
#import "AssetsCollectionViewLayout.h"
#import "DeviceTypesMacros.h"

@implementation TSAssetsPickerController (Internals)

- (NSString *)albumsViewControllerTitle {
    NSString *text = @"Albums";
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerTitleForAlbumsView:)]) {
        text = [self.dataSource assetsPickerControllerTitleForAlbumsView:self];
    }
    return text;
}

- (NSString *)cancelButtonTitle {
    NSString *text = @"Cancel";
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerTitleForCancelButtonInAlbumsView:)]) {
        text = [self.dataSource assetsPickerControllerTitleForCancelButtonInAlbumsView:self];
    }
    return text;
}

- (NSString *)selectButtonTitle {
    NSString *text = @"Select";
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerTitleForSelectButtonInAssetsView:)]) {
        text = [self.dataSource assetsPickerControllerTitleForSelectButtonInAssetsView:self];
    }
    return text;
}

- (NSString *)noAlbumsForSelectedFilter {
    NSString *text = @"No albums for selected filter";
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerTextForCellWhenNoAlbumsAvailable:)]) {
        text = [self.dataSource assetsPickerControllerTextForCellWhenNoAlbumsAvailable:self];
    }
    return text;
}

- (UICollectionViewLayout *)assetsCollectionViewLayoutForOrientation:(UIInterfaceOrientation)orientation {
    AssetsCollectionViewLayout *layout = nil;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerController:needsLayoutForOrientation:)]) {
        layout = (AssetsCollectionViewLayout *)[self.dataSource assetsPickerController:self needsLayoutForOrientation:orientation];
    } else {
        /// Set template layout
        layout = [AssetsCollectionViewLayout new];
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            if (IS_IPHONE) {
                [layout setItemSize:CGSizeMake(74, 74)];
                [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
                [layout setInternItemSpacingY:4.0f];
                [layout setNumberOfColumns:4];
            } else {
                [layout setItemSize:CGSizeMake(115, 115)];
                [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
                [layout setInternItemSpacingY:10.0f];
                [layout setNumberOfColumns:6];
            }
        } else {
            if (IS_IPHONE) {
                [layout setItemSize:CGSizeMake(74, 74)];
                [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
                [layout setInternItemSpacingY:4.0f];
                
                NSUInteger columns = IS_IPHONE_5 ? 7 : 6;
                [layout setNumberOfColumns:columns];
            } else {
                [layout setItemSize:CGSizeMake(115, 115)];
                [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
                [layout setInternItemSpacingY:10.0f];
                [layout setNumberOfColumns:8];
            }
        }
    }
    return layout;
}

- (UIActivityIndicatorView *)activityIndicatorViewForPlace:(ViewPlace)place {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setHidesWhenStopped:YES];
    if ([self.dataSource respondsToSelector:@selector(assetsPickerController:activityIndicatorViewForPlace:)]) {
        indicatorView = [self.dataSource assetsPickerController:self activityIndicatorViewForPlace:place];
    }
    return indicatorView;
}

- (BOOL)shouldShowEmptyAlbums {
    BOOL should = NO;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldShowEmptyAlbums:)]) {
        should = [self.dataSource assetsPickerControllerShouldShowEmptyAlbums:self];
    }
    return should;
}

- (BOOL)shouldDimmEmptyAlbums {
    BOOL should = YES;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldDimmCellsForEmptyAlbums:)]) {
        should = [self.dataSource assetsPickerControllerShouldDimmCellsForEmptyAlbums:self];
    }
    return should;
}

- (BOOL)shouldReverseAlbumsOrder {
    BOOL should = NO;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldReverseAlbumsOrder:)]) {
        should = [self.dataSource assetsPickerControllerShouldReverseAlbumsOrder:self];
    }
    return should;
}

- (BOOL)shouldReverseAssetsOrder {
    BOOL should = YES;
    if ([self.dataSource respondsToSelector:@selector(assetsPickerControllerShouldReverseAssetsOrder:)]) {
        should = [self.dataSource assetsPickerControllerShouldReverseAssetsOrder:self];
    }
    return should;
}

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
