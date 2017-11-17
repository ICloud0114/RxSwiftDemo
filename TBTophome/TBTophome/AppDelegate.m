//
//  AppDelegate.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "AppDelegate.h"
#import "TBRootViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TBRootViewController *root = [[TBRootViewController alloc] init];
    self.window.rootViewController = root;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [HMSDK setDebugEnable:YES];
    [HMSDK initWithAppName:@"TBTophome"];
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
//    NSString *url = @"https://open.orvibo.com/getBrandsList";
//    NSString *token = @"3030e0c9c713497e9b36eaa5cc7c3615";
//    long timestamp = [[NSDate date] timeIntervalSince1970];
//    NSInteger nonce = rand() % 100000;
//    NSArray<NSString *> *params = [NSArray<NSString *> arrayWithObjects:token, [@(timestamp) stringValue], [@(nonce) stringValue], nil];
//    params = [params sortedArrayUsingSelector:@selector(compare:)];
//    NSString *signature = [params componentsJoinedByString:@""];
//    signature = [[signature sha1] uppercaseString];
//    
//    NSString *a = [NSString stringWithFormat:@"https://open.orvibo.com/getBrandsList?signature=%@&timestamp=%@&nonce=%@&deviceType=5&countryCode=CN&lanCode=zh", signature, @(timestamp), @(nonce)];
//
//    // 发起数据任务
//    [[self.session dataTaskWithURL:[NSURL URLWithString:a] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        id reult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@---%@",response,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }] resume];

    return YES;
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
    TBLog(@"%@", [[HMDeviceConfig defaultConfig] currentConnectSSID])

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
