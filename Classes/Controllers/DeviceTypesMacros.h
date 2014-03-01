//
//  DeviceTypesMacros.h
//  TSAssetsPickerController
//
//  Created by Tomasz Szulc on 01.03.2014.
//  Copyright (c) 2014 Tomasz Szulc. All rights reserved.
//

#ifndef TSAssetsPickerController_DeviceTypesMacros_h
#define TSAssetsPickerController_DeviceTypesMacros_h

#define IS_WIDESCREEN ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_IPHONE ([[ [ UIDevice currentDevice ] model ] rangeOfString:@"iPhone"].location != NSNotFound)
#define IS_IPAD ([[ [ UIDevice currentDevice ] model ] rangeOfString:@"iPad"].location != NSNotFound)
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )

#endif
