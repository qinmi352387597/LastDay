//
//  UIImage+ImageRotate.m
//  测试
//
//  Created by 樊腾 on 16/10/9.
//  Copyright © 2016年 FTT. All rights reserved.
//

#import "UIImage+ImageRotate.h"
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
@implementation UIImage (ImageRotate)


//
//- (UIImage *)imageRotatedByDegrees:(CGFloat)degress {
//    
//    CGFloat width = CGImageGetWidth(self.CGImage);
//    CGFloat height = CGImageGetHeight(self.CGImage);
//    
//    CGSize rotatedSize;
//    rotatedSize.width = width;
//    rotatedSize.height = height;
//    
//    UIGraphicsBeginImageContext(rotatedSize);
//    CGContextRef bitmap = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
//    CGContextRotateCTM(bitmap, degress* M_PI / 180);
//    CGContextRotateCTM(bitmap, degress);
//    CGContextScaleCTM(bitmap, -1.0, 1.0);
//    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width / 2 , -rotatedSize.height / 2, rotatedSize.width, rotatedSize.height), self.CGImage);
//    UIImage *newimage =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndPDFContext();
//    return newimage;
//    
//}






- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:radians];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    // 我们的绘图空间的旋转视图的包含框的大小
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    
    // 创建位图上下文
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // 将原点移动到图像中间，这样我们就可以在中心周围旋转和旋转。
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //旋转图像上下文
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    //现在，将旋转/缩放的图像绘制到上下文中
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-width / 2, -height / 2, width, height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
@end
