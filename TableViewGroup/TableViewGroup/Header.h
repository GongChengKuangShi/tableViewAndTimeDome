//
//  Header.h
//  TableViewGroup
//
//  Created by Apple on 2016/12/15.
//  Copyright © 2016年 叶明君. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "NSDictionary+SafeObject.h"
#import "NSString+Util.h"
#import "NSString+Unicode.h"
#import "NSDate+Tools.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#endif /* Header_h */
