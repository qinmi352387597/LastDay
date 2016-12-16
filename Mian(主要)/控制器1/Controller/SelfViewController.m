//
//  SelfViewController.m
//  LastDay
//
//  Created by admin on 2016/11/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SelfViewController.h"
#import "AppDelegate.h"
@interface SelfViewController ()

@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc=[[UIViewController alloc]init];
    AppDelegate *app  =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if (vc == app.window.rootViewController.navigationController.viewControllers.firstObject) {
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    // Do any additional setup after loading the view.
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
