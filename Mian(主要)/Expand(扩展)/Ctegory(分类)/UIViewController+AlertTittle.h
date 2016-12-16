//
//  UIViewController+AlertTittle.h
//  LastDay
//
//  Created by admin on 2016/11/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CallBackBlcok1)();//1
typedef void(^CallBackBlcok2)();//2

@interface UIViewController (AlertTittle)
-(void)AlertTittle:(NSString *)hint;
-(void)AlertDoubleButtonTittle:(NSString *)tittle Message:(NSString *)message OneBtnTittle:(NSString *)message1 OtherBtnTittle:(NSString *)message2 block1:(CallBackBlcok1 )callback1 block2:(CallBackBlcok2 )callback2;
@end
