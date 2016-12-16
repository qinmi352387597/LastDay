//
//  AppDelegate.m
//  LastDay
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <SMS_SDK/SMSSDK.h>


@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
   
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:[[RootViewController alloc] init]];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor cyanColor]];
    
    [self.window setRootViewController:navController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    [SMSSDK registerApp:@"102a068ffb772" withSecret:@"faa48bdb90bc82e33eaee69fa998e6f4"];
    [self setUpBaiDuMap];
    return YES;
    
   
    
    
    
    
    
    
    

}
-(void)setUpBaiDuMap{

    BMKMapManager   *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"ZtXhuzUPCozC8brqPl6rjUFtID4mGFZ5" generalDelegate:self];
    if (ret) {
        NSLog(@"成功");
    }
}
-(void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
