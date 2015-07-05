//
//  RBFilterViewController.m
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "RBFilterViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ShareCommon.h"

#import "FZipCodeViewController.h"
#import "FLocationTypeViewController.h"
#import "FAmenitiesViewController.h"

@interface RBFilterViewController ()

@end

@implementation RBFilterViewController

@synthesize Miles25Btn, Miles2Btn, Miles5Btn;
@synthesize FabSwitchBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"ZIP CODE", @"LOCATION TYPE", @"AMENITIES", nil];
    
    [self SelectMiles2Btn:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Selecting 2 MILES Button
- (IBAction)SelectMiles2Btn:(id)sender {
    
    
    if (_FilterRadius == 2) {
        Miles2Btn.selected      =   NO;
        _FilterRadius = 0;
    } else {
        Miles2Btn.selected      =   YES;
        _FilterRadius = 2;
    }
    
    Miles5Btn.selected      =   NO;
    Miles25Btn.selected     =   NO;
    
    
}

// Selecting 5 MILES Button
- (IBAction)SelectMiles5Btn:(id)sender {
    
    if (_FilterRadius == 5) {
        Miles5Btn.selected      =   NO;
        _FilterRadius = 0;
    } else {
        Miles5Btn.selected      =   YES;
        _FilterRadius = 5;
    }
    
    Miles2Btn.selected      =   NO;
    Miles25Btn.selected     =   NO;
}

// Selecting 25 MILES Button
- (IBAction)SelectMiles25Btn:(id)sender {
    
    if (_FilterRadius == 25) {
        Miles25Btn.selected      =   NO;
        _FilterRadius = 0;
    } else {
        Miles25Btn.selected      =   YES;
        _FilterRadius = 25;
    }
    
    Miles2Btn.selected      =   NO;
    Miles5Btn.selected      =   NO;
}

// Selecting RESET FILTER Button
- (IBAction)SelectResetFilterBtn:(id)sender {
    
//    [self SelectMiles2Btn:nil];
    FabSwitchBtn.on   =   YES;
    
    Miles2Btn.selected      =   NO;
    Miles5Btn.selected      =   NO;
    Miles25Btn.selected      =   NO;
    _FilterRadius = 0;
}


// Saving Filter type
- (IBAction)SavingFilter:(id)sender {
    
    NSString *strFilterRaidus = [NSString stringWithFormat:@"%d", _FilterRadius];
    
    [[NSUserDefaults standardUserDefaults] setObject:strFilterRaidus      forKey:FILTER_RADIUS];
    [[NSUserDefaults standardUserDefaults] setObject:_tmpfilerLocationType forKey:FILTER_RADIUS];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
}


// Going Browse - View14, 15
- (IBAction)GoBack:(id)sender {
    
////    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    tableView.scrollEnabled =   NO;
    
    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"FilterCell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:160];
    
    
    cellLb.text = [DetailsData objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ListItem2 *item = [DetailsData objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        
        FZipCodeViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FZipCodeController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 1) {
        
        FLocationTypeViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FLocationTypeController"];
        
        [self.navigationController pushViewController:view animated:YES];
    } else if (indexPath.row == 2) {
        
        FAmenitiesViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FAmenitiesController"];
        
        [self.navigationController pushViewController:view animated:YES];
    } else {
        
        
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
