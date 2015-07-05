//
//  FavriteHostViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "FavriteHostViewController.h"

@interface FavriteHostViewController ()

@end

@implementation FavriteHostViewController

@synthesize PersonPhoto, FabBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)PushFavBtn:(id)sender {
    
    if (favSelectFlag == 0) {
        
        FabBtn.selected = YES;
        favSelectFlag = 1;
    } else {
        
        FabBtn.selected = NO;
        favSelectFlag = 0;
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
