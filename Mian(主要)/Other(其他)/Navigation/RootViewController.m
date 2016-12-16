//
//  RootViewController.m
//  LastDay
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RootViewController.h"
#import "HcdGuideViewManager.h"
#import "UsersManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"


#import "MCLeftSortsViewController.h"
#import "MCLeftSlideViewController.h"
#import "MCLeftSliderManager.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self LoginEfficacy];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainTabBarController *tabBar=[[MainTabBarController alloc]init];
    MCLeftSortsViewController *leftVC = [[MCLeftSortsViewController alloc] init];
    MCLeftSlideViewController *rootVC = [[MCLeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabBar];
    delegate.window.rootViewController =rootVC;
    [delegate.window makeKeyAndVisible];
    
    [self ADCV];
    
}


-(void)ADCV{
    
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"4"]];
    [images addObject:[UIImage imageNamed:@"2"]];
    [images addObject:[UIImage imageNamed:@"3"]];
    
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                   andButtonTitle:@"立即体验"
                                              andButtonTitleColor:[UIColor whiteColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor whiteColor]];
    
    
    
}

/**
 登录效验
 */


-(void)LoginEfficacy{
   
   BOOL LoginEfficacyReslut= [[UsersManager shareInstance]NullEfficacy];
    if (LoginEfficacyReslut) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainTabBarController *tabBar=[[MainTabBarController alloc]init];
            MCLeftSortsViewController *leftVC = [[MCLeftSortsViewController alloc] init];
            MCLeftSlideViewController *rootVC = [[MCLeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabBar];
            
            delegate.window.rootViewController =rootVC;
        });
        
    }
    else
    {
//        LoginViewController *vc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainTabBarController *tabBar=[[MainTabBarController alloc]init];
            MCLeftSortsViewController *leftVC = [[MCLeftSortsViewController alloc] init];
            MCLeftSlideViewController *rootVC = [[MCLeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabBar];
            
            delegate.window.rootViewController =rootVC;
        });


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
