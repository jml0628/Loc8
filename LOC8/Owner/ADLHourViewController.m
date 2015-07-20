//
//  ADLHourViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ADLHourViewController.h"
#import "AddTimeViewController.h"
#import "AppDelegate.h"
#import "SCLAlertView.h"

@interface ADLHourViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ADLHourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    appDelegate = [AppDelegate sharedDelegate];
    //LocationArrData = [NSArray arrayWithObjects:@"MAY 4-30 / TUE, WED, THU / 4:00Pm - 6:00 PM", @"MAY 5-30 / TUE, WED, SUN / 2:00Pm - 6:00 PM", nil];
    LocationArrData = [[NSMutableArray alloc]init];
    
    if ([appDelegate.updateString isEqualToString:@"update"]) {
        [LocationArrData addObject:[appDelegate.locationDict valueForKey:@"date"]];
    }
    
}
- (void) viewWillAppear:(BOOL)animated
{
    NSString *monthString = [NSString stringWithFormat:@"%@-%@",[appDelegate.locationDict valueForKey:@"start_date"],[appDelegate.locationDict valueForKey:@"end_date"]];
    NSString *dayString = [appDelegate.locationDict valueForKey:@"available_days"];
    
    NSString *timeString = [NSString stringWithFormat:@"%@-%@",[appDelegate.locationDict valueForKey:@"start_time"],[appDelegate.locationDict valueForKey:@"end_time"]];
    NSString *dateString = [NSString stringWithFormat:@"%@ / %@ / %@",monthString,dayString,timeString];
    
    
    if (dayString == nil || [dayString isKindOfClass:[NSNull class]]) {
    }else{
        [LocationArrData removeAllObjects];
        [LocationArrData addObject:dateString];
        [availibiltyTable reloadData];
    }
    [super viewWillAppear:YES];
}


- (IBAction)GoSave:(id)sender {
    [appDelegate.locationDict setObject:[LocationArrData objectAtIndex:0] forKey:@"date"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return [LocationArrData count];;
    } else {
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"AvaliCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (indexPath.section == 1) {
        
        UILabel*        cellLb = (UILabel*) [cell viewWithTag:3700];
        
        
        cellLb.text = [LocationArrData objectAtIndex:indexPath.row];
    } else {
        
        UILabel*        cellLb = (UILabel*) [cell viewWithTag:3700];
        
        
        cellLb.text = @"+  ADD A TIME";
        cell.textLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            AddTimeViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTimeController"];
            [self.navigationController pushViewController:view animated:YES];
            
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
