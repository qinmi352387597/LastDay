//
//  UINavigationBar+category.h
//  导航栏渐变效果
//
//  Created by 陈进荣 on 16/4/4.
//  Copyright © 2016年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (category)
/**
 *  自定义导航栏上的view
 */
@property (nonatomic,strong) UIView * alphaView;

/**
 *  给外界一个方法，来改变颜色
 */
-(void)alphaNavigationBarView:(UIColor *)color;
@end
