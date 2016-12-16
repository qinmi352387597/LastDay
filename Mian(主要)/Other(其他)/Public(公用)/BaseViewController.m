//
//  BaseViewController.m
//  LastDay
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "MCLeftSliderManager.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    menuBtn.frame = CGRectMake(0, 0, 20, 18);
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
//    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    // Do any additional setup after loading the view.
}

/**
 如果需要启用在所有页面都使用侧边栏请解封上面方法 下面方法
 */
//- (void) openOrCloseLeftList
//{
//    
//    if ([MCLeftSliderManager sharedInstance].LeftSlideVC.closed)
//    {
//        [[MCLeftSliderManager sharedInstance].LeftSlideVC openLeftView];
//    }
//    else
//    {
//        [[MCLeftSliderManager sharedInstance].LeftSlideVC closeLeftView];
//    }
//}
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
