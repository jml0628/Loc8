//
//  ADLLocationTypeViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ADLLocationTypeViewController.h"

@interface ADLLocationTypeViewController ()

@end

@implementation ADLLocationTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LocationArrData = [NSArray arrayWithObjects:@"House", @"Apartment or Condo", @"Office", @"Outdoor", @"Garage", @"Commercial", @"Warehouse", @"Club", @"Private patio", @"Other (fill in)", @"OTHER", nil];
    
    LocationCheckArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i < [LocationArrData count]; i++) {
        [LocationCheckArr addObject:[NSNumber numberWithBool:NO]];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return [LocationArrData count];;
    } else {
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"LocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    BOOL selectFlag = [[LocationCheckArr objectAtIndex:indexPath.row] boolValue];
     UIButton*        cellCheckBtn = (UIButton*) [cell viewWithTag:4001];
        
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:4000];
    
    
    cellLb.text = [LocationArrData objectAtIndex:indexPath.row];
    if (selectFlag == true) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
    }
   
    if ( indexPath.row == [LocationArrData count]-1) {
        cellLb.text = @"OTHER";
        cellLb.textColor = [UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f];
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL selectFlag = [[LocationCheckArr objectAtIndex:indexPath.row] boolValue];
    selectFlag = !selectFlag;
    
    [LocationCheckArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:selectFlag]];
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
