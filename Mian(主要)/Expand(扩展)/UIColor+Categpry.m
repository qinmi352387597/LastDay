//
//  UIColor+Categpry.m
//  大学帮帮-企业版
//
//  Created by cmcc on 16/7/29.
//  Copyright © 2016年 HangLong Lv. All rights reserved.
//

#import "UIColor+Categpry.h"

@implementation UIColor (Categpry)


+ (UIColor *)getColor:(NSString *)RGB {
    long red = strtoul([[RGB substringWithRange:NSMakeRange(1, 2)]UTF8String], 0, 16);
    long green = strtoul([[RGB substringWithRange:NSMakeRange(3, 2)]UTF8String], 0, 16);
    long blue = strtoul([[RGB  substringWithRange:NSMakeRange(5, 2)]UTF8String], 0, 16);
    return [UIColor colorWithRed:red / 255.0f green:green/ 255.0f blue:blue / 255.0f alpha:1];
}




@end
