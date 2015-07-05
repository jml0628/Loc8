//
//  AppDelegate.m
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "AppDelegate.h"
#import "Config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

int PersonLoginFlag;
int FilterRadius;
int userFlag;
int pageFlag;
int appSideViewFlag;

CGFloat ANIMATION_DURATION;
CGFloat LITTLE_SPACE;
CGFloat animatedDistance;
CGSize  keyboardSize;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIImage *tabBarBackground = [UIImage imageNamed:@"tabbarBackground.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    NSLog(@"~~4444~~");
    // Format login flag -> 0
//    PersonLoginFlag = 0;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    return YES;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"~~~~~");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"111");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"222");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"333");
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    
    int nClientID = (int)[pref integerForKey:@"userID"];
    if (nClientID == 0 || nClientID == -1)
        return;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"444");
}

@end
