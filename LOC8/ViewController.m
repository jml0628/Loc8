//
//  ViewController.m
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
#import "TabbarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize LoginBtn, SignUpBtn;
@synthesize bottomView, backgroundIamge, loadingIcon, loadingTxt, loadingView, loc8TitleIamge;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0"   forKey:USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updatescreen:) userInfo:nil repeats:YES];
    
    bottomView.hidden       =   YES;
    loc8TitleIamge.hidden   =   YES;
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatescreen:(NSTimer *)timer
{
    static int counter = 1;
    
    counter++;
    
    if (counter < 30) {
        
        float radian = 360 * counter / 20 * M_PI / 180.0f / 1.5;
        
        loadingIcon.transform = CGAffineTransformMakeRotation(radian);
        
    } else {
        
        bottomView.hidden       = NO;
        loadingView.hidden      = YES;
        loc8TitleIamge.hidden   = NO;
    }
}

@end
