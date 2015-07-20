//
//  ADLAmenityViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ADLAmenityViewController.h"
#import "AppDelegate.h"

@interface ADLAmenityViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ADLAmenityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [AppDelegate sharedDelegate];
    AmenitiesData = [NSArray arrayWithObjects:@"Living Room", @"Kitchen", @"Bedroom", @"Bed", @"Shower", @"Bathroom", @"Towels", @"Couch", @"Bed", @"Chair", @"Table", @"Private", @"Public", @"Pool", @"Spa", @"Wireless", @"Sex furniture", @"OTHER", nil];
    
    NSString *location_amenty = [appDelegate.locationDict valueForKey:@"location_amenty"];
    NSLog(@"location type string : %@", location_amenty);

 
    AmenitiesCheckArr = [[NSMutableArray alloc] init];

    for (int i=0; i < [AmenitiesData count]; i++) {
        
        NSString* locationArrItem = (NSString*)[AmenitiesData objectAtIndex:i];
        
        if([appDelegate.updateString isEqualToString:@"update"]){
            
            if ([location_amenty isEqualToString:locationArrItem]){
                [AmenitiesCheckArr addObject:[NSNumber numberWithBool:YES]];
            }else{
                [AmenitiesCheckArr addObject:[NSNumber numberWithBool:NO]];
            }
        }else{
            [AmenitiesCheckArr addObject:[NSNumber numberWithBool:NO]];
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
    NSString *locationType =@"";
    for(int i = 0; i < AmenitiesCheckArr.count ;i++ )
    {
        BOOL Flag = [[AmenitiesCheckArr objectAtIndex:i] boolValue];
        if (Flag == true) {
            locationType = [NSString stringWithFormat:@"%@%@",locationType,[AmenitiesData objectAtIndex:i]];
            [appDelegate.locationDict setObject:locationType forKey:@"location_amenty"];
        } else {
            
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [AmenitiesData count];;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *simpleTableIdentifier = @"AmenitiesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    

        
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:4100];
    
    cellLb.text = [AmenitiesData objectAtIndex:indexPath.row];
    
    if ( indexPath.row == [AmenitiesData count]-1) {
        cellLb.textColor = [UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f];
    }

    
    UIButton *cellCheckBtn = (UIButton*) [cell viewWithTag:4101];
    
     BOOL selectFlag = [[AmenitiesCheckArr objectAtIndex:indexPath.row] boolValue];
    
    if (selectFlag == true) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL selectFlag = [[AmenitiesCheckArr objectAtIndex:indexPath.row] boolValue];
    
    for (int i = 0; i < AmenitiesCheckArr.count; ++i){
        [AmenitiesCheckArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
    }
    
    if (selectFlag){
        selectFlag = NO;
    }else{
        selectFlag = YES;
    }
    
    [AmenitiesCheckArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:selectFlag]];
    
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
