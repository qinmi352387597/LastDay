//
//  UIViewController+AlertTittle.m
//  LastDay
//
//  Created by admin on 2016/11/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIViewController+AlertTittle.h"

@implementation UIViewController (AlertTittle)
-(void)AlertTittle:(NSString *)hint{
    
    UIAlertController *vc=[UIAlertController alertControllerWithTitle:@"提示信息" message:hint preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:^{
    }];
    
}
-(void)AlertDoubleButtonTittle:(NSString *)tittle Message:(NSString *)message OneBtnTittle:(NSString *)message1 OtherBtnTittle:(NSString *)message2 block1:(CallBackBlcok1 )callback1 block2:(CallBackBlcok2 )callback2{
    UIAlertController *vc=[UIAlertController alertControllerWithTitle:tittle message: message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:message1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         callback1();
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:message2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       callback2();
    }];
    [vc addAction:action];
    [vc addAction:action1];
    [self presentViewController:vc animated:YES completion:^{
    }];


}

@end
