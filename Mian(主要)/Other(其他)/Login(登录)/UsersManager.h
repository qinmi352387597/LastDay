//
//  UsersManager.h
//  EP-T
//
//  Created by 刘锐 on 14-11-26.
//  Copyright (c) 2014年 刘锐. All rights reserved.
//
#import<Foundation/Foundation.h>
#import "UsersManager.h"
#import "User.h"
@interface UsersManager :NSObject
//入口
+ (id)shareInstance;

- (User*)queryUserInfo;
//更新user设置
- (void)saveUserInfo:(User*)userInfo;
//删除用户设置
- (BOOL)deleteUserInfo:(User*)userInfo;
//空数据效验
-(BOOL)NullEfficacy;
@end
