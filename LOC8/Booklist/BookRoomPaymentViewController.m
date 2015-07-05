//
//  BookRoomPaymentViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "BookRoomPaymentViewController.h"

#import "SettingsNAvViewController.h"
#import "TabbarViewController.h"

@interface BookRoomPaymentViewController ()

@end

@implementation BookRoomPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"ADD CARD", nil];
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoBookRoom:(id)sender {
    
//    //    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    
    [ctrl setSelectedIndex:1];
    
    [self presentViewController:ctrl animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"CardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:90];
    
    
    cellLb.text = [DetailsData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SettingsNAvViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsNAvController"];
    
    [self presentViewController:view animated:YES completion:nil];
    

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
