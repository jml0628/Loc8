//
//  GenderViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "GenderViewController.h"
#import "Config.h"

@interface GenderViewController ()

@end

@implementation GenderViewController
@synthesize saveBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"MALE", @"FEMALE", @"OTHER", nil];
    
    if (userFlag == 2) {
        saveBtn.hidden = YES;
    } else
        saveBtn.hidden = NO;
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    tableView.scrollEnabled =   NO;
    
    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"GenderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:320];
    UIButton*       cellCheckBtn = (UIButton*) [cell viewWithTag:321];
    
    
    cellLb.text = [DetailsData objectAtIndex:indexPath.row];

    
    if (GenderType == indexPath.row) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
