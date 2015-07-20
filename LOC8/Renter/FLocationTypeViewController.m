//
//  FLocationTypeViewController.m
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "FLocationTypeViewController.h"
#import "AppDelegate.h"


@interface FLocationTypeViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation FLocationTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LocationArrData = [NSArray arrayWithObjects:@"House", @"Apartment or Condo", @"Office", @"Outdoor", @"Garage", @"Commercial", @"Warehouse", @"Club", @"Private patio", @"Other", nil];
    
    CheckList = [[NSMutableArray alloc] init];
    

    
    for (int i=0; i < [LocationArrData count]; i++) {
        [CheckList addObject:[NSNumber numberWithBool:NO]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [LocationArrData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"LocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:180];

    BOOL selectFlag = [[CheckList objectAtIndex:indexPath.row] boolValue];
    UIButton*        cellCheckBtn = (UIButton*) [cell viewWithTag:181];
    
    
    cellLb.text = [LocationArrData objectAtIndex:indexPath.row];
    if (selectFlag == true) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL selectFlag = [[CheckList objectAtIndex:indexPath.row] boolValue];
    selectFlag = !selectFlag;
    
    [CheckList replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:selectFlag]];
    
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
