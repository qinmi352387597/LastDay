//
//  LoginViewController.m
//  LastDay
//
//  Created by admin on 2016/11/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "IHKeyboardAvoiding.h"
#import "MBProgressHUD.h"
#import "DGTimerButton.h"
#import "UIViewController+AlertTittle.h"
#import "UsersManager.h"
#import <SMS_SDK/SMSSDK.h>

@interface LoginViewController ()<UITextFieldDelegate>

// 手机图片
@property (nonatomic , strong) UIImageView *Phoneimage;
// 验证码图片
@property (nonatomic , strong) UIImageView *Testimage;
@end

@implementation LoginViewController
{
    UIButton *_SureBtn;
    UITextField *_PhoneTf;
    UITextField *_TestTf;
    DGTimerButton *bu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
}
-(void)createUI{

    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:view];
    
    UILabel *tittle=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    tittle.text = @"注册";
    tittle.textAlignment=NSTextAlignmentCenter;
    tittle.font=[UIFont systemFontOfSize:19.0];
    tittle.textColor=[UIColor whiteColor];
    [self.view addSubview:tittle];
    
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"top_bar_return@2x"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 20, 30, 30);
    [backButton addTarget:self action:@selector(clcikBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    UIImageView *HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 96) / 2, 66, 96, 96)];
    HeadImage.image = [UIImage imageNamed:@"register_head"];
    HeadImage.layer.masksToBounds = YES;
    HeadImage.layer.cornerRadius = 48;
    [self.view addSubview:HeadImage];
    
    _PhoneTf = [[UITextField alloc]init];
    [IHKeyboardAvoiding setAvoidingView:self.view withTarget:_PhoneTf];
    _PhoneTf.frame = CGRectMake(60,66+96+50, kScreenWidth - 100, 20);
    _PhoneTf.borderStyle = UITextBorderStyleNone ;
    _PhoneTf.keyboardType = UIKeyboardTypeNumberPad;
    [_PhoneTf addTarget:self action:@selector(phone:) forControlEvents:UIControlEventAllEditingEvents];
    _PhoneTf.placeholder = @"请输入您的手机号";
    _PhoneTf.tag = 100 ;
    [self.view addSubview:_PhoneTf];
    
    UIImageView *leftiamgeview =[[UIImageView alloc]initWithFrame:CGRectMake(15, 66+96+50 , 20, 20)];
    _Phoneimage = leftiamgeview;
    leftiamgeview.image = [UIImage imageNamed:@"pnumber"];
    [self.view addSubview:leftiamgeview] ;
    
    
    _TestTf = [[UITextField alloc]init];
    _TestTf.frame = CGRectMake(60,66+96+50+50 , kScreenWidth - 180, 20);
    _TestTf.borderStyle = UITextBorderStyleNone ;
    [IHKeyboardAvoiding setAvoidingView:self.view withTarget:_TestTf];
    _TestTf.keyboardType = UIKeyboardTypeNumberPad;
    _TestTf.placeholder = @"请输入验证码";
    _TestTf.tag = 101;
    _TestTf.delegate = self;
    [_TestTf addTarget:self action:@selector(phone:) forControlEvents:UIControlEventAllEditingEvents];
    [self.view addSubview:_TestTf];

    UIImageView *leftiamgeview1 =[[UIImageView alloc]initWithFrame:CGRectMake(15, 66+96+50+50, 20, 20)];
    _Testimage = leftiamgeview1;
    leftiamgeview1.image = [UIImage imageNamed:@"pwd"];
    [self.view addSubview:leftiamgeview1] ;
    
    bu = [DGTimerButton buttonWithType:UIButtonTypeCustom];
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bu.titleLabel.font=[UIFont systemFontOfSize:14];
    [bu setTitle:@"获取" forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor lightGrayColor]];
    [bu addTarget:self action:@selector(beginTimer) forControlEvents:UIControlEventTouchUpInside];
    [bu setFrame:CGRectMake(kScreenWidth - 180+60, 66+96+50+50, 80, 30)];
    
    
    bu.contentMode = UIViewContentModeScaleAspectFit;
    bu.layer.cornerRadius = 10;
    bu.layer.masksToBounds = YES;
    
    
    
   
    [bu setDGTimerButtonWithDuration:60
                         runingColor:[UIColor grayColor]                                               runingTextColor:[UIColor whiteColor]
                       runingImgName:nil
                           formatStr:@"%ld"
                            buStatus:^(BUStatus status) {
                                
                                if (status==BUStatusRuning) {
                                    //计时中
                                    NSLog(@"计时中");
                                    
                                }else if (status==BUStatusCancel){
                                    //结束了（手动结束了，没有超时）
                                    NSLog(@"手动结束了，没有超时");
                                    
                                    
                                }else if (status==BUStatusFinish){
                                    //计时结束了 超时了
                                    NSLog(@"计时结束了 超时了");
                                }
                                
                            }];
    [self.view addSubview:bu];
    
    
    
    
    _SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _SureBtn.frame = CGRectMake(15, 66+96+50+50+50 + 3 , kScreenWidth - 30 , 44);
    _SureBtn.layer.cornerRadius = 6;
    _SureBtn.backgroundColor = [UIColor greenColor];
    [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SureBtn addTarget:self action:@selector(Sure) forControlEvents:UIControlEventTouchUpInside];
    _SureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_SureBtn];
    
   
    
}
-(void)Sure{

    [SMSSDK commitVerificationCode:_TestTf.text phoneNumber:_PhoneTf.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        {
            if (!error)
            {
                User *user=[[User alloc]init];
                user.passWord=_PhoneTf.text;
                user.userName=_PhoneTf.text;
                
                [[UsersManager shareInstance]saveUserInfo:user];
                [self dismissViewControllerAnimated:YES completion:nil];
               // NSLog(@"验证成功");
            }
            else
            {
                [self AlertTittle:error.description];
                //NSLog(@"错误信息:%@",error);
            }
        }
    }];
}
-(void)openSMSSdk{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_PhoneTf.text zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];

}
-(void)beginTimer{
    if (_PhoneTf.text.length > 0) {
        if (_PhoneTf.text.length == 11) {
            if ([self isMobile:_PhoneTf.text]) {
                [bu beginTimers];
                [self.view endEditing:YES];
                [self openSMSSdk];
                
            }else{
                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:HUD];
                HUD.labelText =@"您输入手机号格式有误,请重新输入";
                HUD.labelFont = [UIFont systemFontOfSize:14];
                HUD.mode = MBProgressHUDModeText;
                [HUD showAnimated:YES whileExecutingBlock:^{
                    sleep(1);
                } completionBlock:^{
                    [HUD removeFromSuperview];
                    _PhoneTf.text = @"";
                    _Phoneimage.image = [UIImage imageNamed:@"pnumber"];
                    
                    
                }];

            }
        }else{
        
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText =@"您输入手机号格式有误,请重新输入";
            HUD.labelFont = [UIFont systemFontOfSize:14];
            HUD.mode = MBProgressHUDModeText;
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                [HUD removeFromSuperview];
                _PhoneTf.text = @"";
                _Phoneimage.image = [UIImage imageNamed:@"pnumber"];
                
                
            }];

        }
    
    }else{
    
        [self AlertTittle:@"手机号不能为空!"];
    
    }
}
- (void)phone:(UITextField *)phone {
    switch (phone.tag) {
        case 100:
        {
            // 判断手机号
            if (phone.text.length > 0) {
                _Phoneimage.image = [UIImage imageNamed:@"pnumber_blue"];
                if (phone.text.length == 11) {
                    if ([self isMobile:phone.text]) {
                       [self.view endEditing:YES];
                    }else {
                        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
                        [self.view addSubview:HUD];
                        HUD.labelText =@"您输入手机号格式有误,请重新输入";
                        HUD.labelFont = [UIFont systemFontOfSize:14];
                        HUD.mode = MBProgressHUDModeText;
                        [HUD showAnimated:YES whileExecutingBlock:^{
                            sleep(1);
                        } completionBlock:^{
                            [HUD removeFromSuperview];
                            _PhoneTf.text = @"";
                            _Phoneimage.image = [UIImage imageNamed:@"pnumber"];
                            
                            
                        }];
                        
                    }
                }else if (phone.text.length >11){
                    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:HUD];
                    HUD.labelText =@"您输入手机号格式有误,请重新输入";
                    HUD.labelFont = [UIFont systemFontOfSize:14];
                    HUD.mode = MBProgressHUDModeText;
                    [HUD showAnimated:YES whileExecutingBlock:^{
                        sleep(1);
                    } completionBlock:^{
                        [HUD removeFromSuperview];
                        _PhoneTf.text = @"";
                        _Phoneimage.image = [UIImage imageNamed:@"pnumber"];
                       
                        
                    }];
                }
                
            }else {
                _Phoneimage.image = [UIImage imageNamed:@"pnumber"];
            }
            
        }
            break;
        case 101:
        {
            if (phone.text.length > 0) {
                _Testimage.image = [UIImage imageNamed:@"pwd_blue"];
            }else  {
                _Testimage.image = [UIImage imageNamed:@"pwd"];
            }
        }
            break;
        default:
            break;
    }
    if (_TestTf.text.length > 0 && _PhoneTf.text.length > 0) {
        _SureBtn.backgroundColor =  [UIColor greenColor];
        
    }else {
        _SureBtn.backgroundColor = [UIColor grayColor];
    }
}



-(void)clcikBack:(UIButton *)btn{
  
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (BOOL)isNum:(NSString *)num {
    NSString *MOBILE = @"^[1-9]\\d{5}";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:num]) {
        return YES;
    }else {
        return NO;
    }
}
#pragma mark 判断手机号是否有误
- (BOOL)isMobile:(NSString *)mobile{
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobile]) {
        return YES;
    }else {
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
