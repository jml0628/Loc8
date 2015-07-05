//
//  OwnerTabbarViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "OwnerTabbarViewController.h"
#import "Config.h"

@interface OwnerTabbarViewController ()

@end

@implementation OwnerTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageFlag = 2;
    
    NSLog(@"pageFlag = %d", pageFlag);
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
