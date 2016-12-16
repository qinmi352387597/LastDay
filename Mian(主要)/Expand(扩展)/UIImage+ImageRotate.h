//
//  UIImage+ImageRotate.h
//  测试
//
//  Created by 樊腾 on 16/10/9.
//  Copyright © 2016年 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);
@interface UIImage (ImageRotate)
- (UIImage *)imageRotatedByDegrees:(CGFloat)degress ;




- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
@end
