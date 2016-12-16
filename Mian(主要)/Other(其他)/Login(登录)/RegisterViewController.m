//
//  RegisterViewController.m
//  LastDay
//
//  Created by admin on 2016/11/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "IHKeyboardAvoiding.h"
#import "MBProgressHUD.h"
#import "DGTimerButton.h"
#import "UIViewController+AlertTittle.h"
#import "UsersManager.h"
#import <SMS_SDK/SMSSDK.h>

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NameTextFile;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFile;
@property (weak, nonatomic) IBOutlet DGTimerButton *Verification;

@property (weak, nonatomic) IBOutlet UITextField *VerificationTextFile;



@property (weak, nonatomic) IBOutlet UITextField *EmailTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *Promiss;


@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *clear;


@property (weak, nonatomic) IBOutlet UILabel *NameLale;
@property (weak, nonatomic) IBOutlet UILabel *VerificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmailLable;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIAndDelegate];
    
}
- (IBAction)dismis:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)submitSel:(id)sender {
    if ([_NameLale.text isEqualToString:@"验证通过"]&&[_VerificationLabel.text isEqualToString:@"验证通过"]&&[_EmailLable.text isEqualToString:@"验证通过"]&&![_VerificationTextFile.text isEqualToString:@""])
 {
     NSLog(@"提交成功");
     User *user=[[User alloc]init];
     user.passWord=_phoneTextFile.text;
     user.userName=_NameTextFile.text;
     
     [[UsersManager shareInstance]saveUserInfo:user];
     [self dismissViewControllerAnimated:YES completion:nil];
    
 }else
     [self AlertTittle:@"请完善数据项"];
    
}
- (IBAction)CacelSel:(id)sender {
    
     NSLog(@"取消");
    
}
-(void)setupUIAndDelegate{
    _NameTextFile.delegate=self;
    _NameTextFile.placeholder = @"请输入用户名";
    _NameLale.text=@"";
    
    _phoneTextFile.delegate=self;
    [IHKeyboardAvoiding setAvoidingView:self.view withTarget:_phoneTextFile];
    _phoneTextFile.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFile.placeholder = @"请输入您的手机号";
     _VerificationLabel.text=@"";
    
    
     [_Verification setTitle:@"获取" forState:UIControlStateNormal];
     [_Verification addTarget:self action:@selector(beginTimer) forControlEvents:UIControlEventTouchUpInside];
     [_Verification setDGTimerButtonWithDuration:60
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
    
    [_Verification setBackgroundColor:[UIColor lightGrayColor]];
    _Verification.titleLabel.font=[UIFont systemFontOfSize:14];
    _Verification.contentMode = UIViewContentModeScaleAspectFit;
    _Verification.layer.cornerRadius = 10;
    _Verification.layer.masksToBounds = YES;
    

    _VerificationTextFile.delegate=self;
    _VerificationTextFile.keyboardType = UIKeyboardTypeNumberPad;
    _VerificationTextFile.placeholder = @"验证码";

    _EmailTextFiled.delegate=self;
    _EmailLable.text=@"";
    _EmailTextFiled.placeholder = @"请输入邮箱地址";
}
-(void)beginTimer{
    if (![_phoneTextFile.text isEqualToString:@""]&&[self isMobile:_phoneTextFile.text]==YES) {
        [_Verification beginTimers];
        [self openSMSSdk];
        [self.view endEditing:YES];
       
    }
else
    [self AlertTittle:@"您输入手机号格式有误,请重新输入"];
}

-(void)openSMSSdk{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTextFile.text zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];
    
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



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_NameTextFile resignFirstResponder];
    [_phoneTextFile resignFirstResponder];
    [_VerificationTextFile resignFirstResponder];
    [_EmailTextFiled resignFirstResponder];

   

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==_NameTextFile) {
        _NameLale.text=@"";
    }
    if (textField==_phoneTextFile) {
        _VerificationLabel.text=@"";
    }
    if (textField==_EmailTextFiled) {
        _EmailLable.text=@"";
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==_NameTextFile) {
        if (textField.text.length>5) {
            _NameLale.text=@"验证通过";
        }
        else
            [self AlertTittle:@"长度应大于5"];
    }
    if (textField==_phoneTextFile) {
        if (textField.text.length==11&&[self isMobile:_phoneTextFile.text]) {
            _VerificationLabel.text=@"验证通过";
        }
        else
            [self AlertTittle:@"手机号码不正确"];
        
        
    }
   
    if (textField==_EmailTextFiled) {
        if ([self validateEmail:_EmailTextFiled.text]) {
            _EmailLable.text=@"验证通过";
        }
        else
             [self AlertTittle:@"邮箱格式不正确"];
        
    }
    if (textField==_VerificationTextFile) {
        if (textField.text.length>0) {
            
            [SMSSDK commitVerificationCode:_VerificationTextFile.text phoneNumber:_phoneTextFile.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
                {
                    if (!error)
                    {
                        [self AlertTittle:@"验证成功"];
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
        else
            [self AlertTittle:@"验证码不能为空"];
    }
    
    
    
    
}
-(BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
