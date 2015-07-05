//
//  SettingHostProViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "SettingHostProViewController.h"
#import "Config.h"

#import "HeightViewController.h"
#import "WeightViewController.h"
#import "GenderViewController.h"
#import "OwnerTabbarViewController.h"

@interface SettingHostProViewController ()

@end

@implementation SettingHostProViewController
@synthesize  AgeTx, Titlelb, SaveBtn, DoneView, DoneBtn;
@synthesize viewFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"HEIGHT", @"WEIGHT", @"GENDER", nil];
    
    AgeTx.keyboardType = UIKeyboardTypeNumberPad;
    
    
    if (viewFlag == 1) {
        
        Titlelb.text = @"HOST PROFILE";
        SaveBtn.hidden  =   YES;
    } else {
        
        Titlelb.text = @"HOST SIGN UP";
        SaveBtn.hidden  =   NO;
    }
    
    int     textfeildOriginY;
    DoneView.hidden     =   YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Settings  - View22
- (IBAction)GoBack:(id)sender {
    
//    if (userFlag != 2) {
//        [self.navigationController popViewControllerAnimated:YES];
//    } else {
//        
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

// Going Location  - View26
- (IBAction)GoOwnerLocation:(id)sender {
    
    if (PersonLoginFlag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        PersonLoginFlag = 1;
        
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
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    tableView.scrollEnabled =   NO;
    
    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"ProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:130];
    
    
    cellLb.text = [DetailsData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    ListItem2 *item = [DetailsData objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        
        HeightViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"HeightController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 1) {
        
        WeightViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"WeightController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
        
    } else if (indexPath.row == 2) {
        
        GenderViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"GenderController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else {
        
        
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    DoneView.hidden =   NO;
    
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight - 20) ;
        viewFrame.origin.y -= animatedDistance;

    }

    
    textfeildOriginY    = textFieldRect.origin.y;
    
    if (userFlag == 2) {
        
        return  NO;
    } else
        return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    DoneView.hidden =   YES;
    [textField resignFirstResponder];
    
    return YES;
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    if(!self.isViewLoaded || !self.view.window) {
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardFrameInWindow;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrameInWindow];
    
    int keyboardHeight = keyboardFrameInWindow.size.height;
    
    DoneView.hidden =   NO;
    
    UIView *moveView    = [self.view viewWithTag:5];
    CGRect frame        = moveView.frame;
    
    [moveView removeFromSuperview];
    
    frame.origin.y = self.view.bounds.size.height - keyboardHeight - 30;
    moveView.frame  =   frame;
    
    [self.view addSubview:moveView];
    
    int offset = textfeildOriginY - keyboardHeight;
    
    if (offset > 0) {
        [myRegScroller setContentOffset:CGPointMake(0, offset) animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [AgeTx setDelegate:self];
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
}

// Collapse

- (IBAction)HiddenKeyboard :(id)sender {
    
    [myRegScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [AgeTx resignFirstResponder];
    
    DoneView.hidden =   YES;
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
