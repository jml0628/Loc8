//
//  PropertyOwnProfileViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "PropertyOwnProfileViewController.h"
#import "MessageViewController.h"

@interface PropertyOwnProfileViewController ()

@end

@implementation PropertyOwnProfileViewController
@synthesize FabBtn, PushFavBtn;
@synthesize AvatarPic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AvatarPic.layer.cornerRadius    =   AvatarPic.frame.size.width / 2;
    AvatarPic.clipsToBounds         =   YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoMessageView:(id)sender {
    
    MessageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
    
    view.goneFlag = 1;
    
    [self.navigationController pushViewController:view animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
