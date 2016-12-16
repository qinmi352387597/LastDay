//
//  MainTabBarController.m
//  ITInformation
//
//  Created by QianFeng on 16/2/23.
//  Copyright © 2016年 秦密. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainModel.h"
#import "AppDelegate.h"
#define LEFT_WIDTH  [UIScreen mainScreen].bounds.size.width/3.0
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *tabbarModelArray  =[self loadConfigFile];
    [self createViewControllers:tabbarModelArray];
   

}


- (NSArray *)loadConfigFile {
    // 检查一下是否需要使用网络的配置文件，如果需要就去下载，以便下一次使用
    //在这里直接加载本地的配置文件就行了
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *filePath= [[NSBundle mainBundle]pathForResource:@"MainPlist.plist" ofType:nil];
    NSArray *contentArray = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *item in contentArray) {
        MainModel *model = [[MainModel alloc]init];
        [model setValuesForKeysWithDictionary:item];
        [resultArray addObject:model];
    }
    
    return resultArray;
}
//创建子视图控制器
- (void)createViewControllers:(NSArray *)tabbarModelArray {
    NSMutableArray *resultArray =[NSMutableArray new];
    for (MainModel *model in tabbarModelArray) {
        UIViewController *vc = [[NSClassFromString( model.className) alloc]initWithNibName:model.className bundle:nil
                                ];

        vc.title = model.title;
       
        vc.tabBarItem.title = model.title2;
        vc.tabBarItem.image = [[UIImage imageNamed:model.image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",model.image]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        vc.tabBarItem.imageInsets = insets;
        
        
        [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor purpleColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        
        nav.navigationBar.titleTextAttributes = dict;
        [resultArray addObject:nav];
        
    }
    self.viewControllers = resultArray;
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
