//
//  ADLAttViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ADLAttViewController.h"
#import "AppDelegate.h"
@interface ADLAttViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ADLAttViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [AppDelegate sharedDelegate];
    AmenitiesData = [NSArray arrayWithObjects:@"HOST ABSENT", @"HOST PRESENT", @"UNKNOWN", nil];
    
    if ([appDelegate.updateString isEqualToString:@"update"]) {
        NSString *string = [appDelegate.locationDict valueForKey:@"location_ateendency"];
        if ([string isEqualToString:@"HOST ABSENT"]) {
            attendence = [AmenitiesData objectAtIndex:0];
            GenderType = (int)0;
        }
        if ([string isEqualToString:@"HOST PRESENT"]) {
            attendence = [AmenitiesData objectAtIndex:0];
            GenderType = (int)1;
        }
        if ([string isEqualToString:@"UNKNOWN"]) {
            attendence = [AmenitiesData objectAtIndex:0];
            GenderType = (int)2;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Browse list -  Filter - View16
- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoSave:(id)sender {
     [appDelegate.locationDict setObject:attendence forKey:@"location_ateendency"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AmenitiesData count];;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"LocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    

    UILabel*        cellLb = (UILabel*) [cell viewWithTag:4200];
    UIButton*        cellCheckBtn = (UIButton*) [cell viewWithTag:4201];
    
    
    cellLb.text = [AmenitiesData objectAtIndex:indexPath.row];

    if (GenderType == indexPath.row) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    attendence = [AmenitiesData objectAtIndex:indexPath.row];
    GenderType = (int) indexPath.row;
    
    [tableView reloadData];
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
