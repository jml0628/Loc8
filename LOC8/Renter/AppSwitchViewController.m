//
//  AppSwitchViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//


#import "AppSwitchViewController.h"
#import "HostSignNavViewController.h"
#import <UIKit/UIKit.h>
#import "Config.h"
#import "TabbarViewController.h"
#import "OwnerTabbarViewController.h"


@interface AppSwitchViewController ()

@end

@implementation AppSwitchViewController
@synthesize blurImage, matchView, blurImage1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
/*    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    // add the effect view to the image view
    [self.blurImage1 addSubview:effectView];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Booking - View20
- (IBAction)GoBack:(id)sender {
//    [UIView animateWithDuration:0.4 animations:^{
//        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
//    }];
    self.view.alpha = 1.0f;
    
    [UIView animateWithDuration:0.0 animations:^{
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
        self.view.alpha = 0.0f;
    }];
}

// Going Need place - View20
- (IBAction)GoBooking:(id)sender {
    
    if (pageFlag == 1) {
        self.view.alpha = 1.0f;
        
        [UIView animateWithDuration:0.0 animations:^{
            
            self.view.alpha = 0.0f;
        }];
    } else {
        
        
        TabbarViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
        
        [ctrl.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBackground.png"]];
        UITabBar*           tabBar = ctrl.tabBar;
        
        UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
        UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
        UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
        
        [tabBarItem0 setSelectedImage:[[UIImage imageNamed:@"tabitem1Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem0 setImage:[[UIImage imageNamed:@"tabitem1B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tabitem2Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem1 setImage:[[UIImage imageNamed:@"tabitem2B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tabitem3Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem2 setImage:[[UIImage imageNamed:@"tabitem3B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [ctrl setSelectedIndex:0];
        
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    
    
}

// Going Got Place - View
- (IBAction)GoGotPlace:(id)sender {
    
    if (pageFlag == 2) {
        self.view.alpha = 1.0f;
        
        [UIView animateWithDuration:0.0 animations:^{
            
            self.view.alpha = 0.0f;
        }];
    } else {
        
        
        if (PersonLoginFlag == 1) {
            
            OwnerTabbarViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"OwnerTabbarController"];
            
            [ctrl.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBackground"]];
            UITabBar*           tabBar = ctrl.tabBar;
            
            UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
            UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
            UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
            
            [tabBarItem0 setSelectedImage:[[UIImage imageNamed:@"tabitem2Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabBarItem0 setImage:[[UIImage imageNamed:@"tabitem1B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tabitem4Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabBarItem1 setImage:[[UIImage imageNamed:@"tabitem4B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tabitem3Y"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabBarItem2 setImage:[[UIImage imageNamed:@"tabitem3B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            [ctrl setSelectedIndex:1];
            
            
            [self presentViewController:ctrl animated:YES completion:nil];
            
        } else {
            HostSignNavViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"HostSignNavController"];
            
            [self presentViewController:view animated:YES completion:nil];
        }
        
    }
    
    
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
