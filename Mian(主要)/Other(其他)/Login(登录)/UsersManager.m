//
//  UsersManager.m
//  EP-T
//
//  Created by 刘锐 on 14-11-26.
//  Copyright (c) 2014年 刘锐. All rights reserved.
//

#import "UsersManager.h"

static UsersManager *instnce;
@implementation UsersManager
//入口
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[UsersManager alloc] init];
    }
    return instnce;
}

- (User*)queryUserInfo
{
    User *model=[[User alloc]init];
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord=[user stringForKey:@"passWord"];
    NSString *userName=[user stringForKey:@"userName"];
    if (![passWord isEqualToString:@""]&&![userName isEqualToString:@""]) {
        model.passWord=passWord;
        model.userName=userName;
        
        return model;
    }
    return nil;
    
}

//保存用户登录信息
-(void)saveUserInfo:(User*)userInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userInfo.passWord forKey:@"passWord"];
    [user setValue:userInfo.userName forKey:@"userName"];

  
    
}

//删除用户设置
- (BOOL)deleteUserInfo:(User*)userInfo
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord=[user stringForKey:@"passWord"];
    NSString *userName=[user stringForKey:@"userName"];
    if ([passWord isEqualToString:userInfo.passWord]&&[userName isEqualToString:userInfo.userName]) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:@"" forKey:@"passWord"];
        [user setValue:@"" forKey:@"userName"];
        
        return YES;
    }
    return NO;
    
}
-(BOOL)NullEfficacy{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord=[user stringForKey:@"passWord"];
    NSString *userName=[user stringForKey:@"userName"];
    if (![passWord isEqualToString:@""]&&![userName isEqualToString:@""]&&userName!=nil&&passWord!=nil) {
    
        return YES;
    }

    return NO;


}
@end
