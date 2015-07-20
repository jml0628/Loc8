//
//  AddTimeViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "AddTimeViewController.h"
#import "AppDelegate.h"

@interface AddTimeViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation AddTimeViewController

- (void)viewDidLoad {
    appDelegate = [AppDelegate sharedDelegate];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"MONDAY", @"TUEDAY", @"WEDNESDAY", @"THUSDAY",@"FRIDAY", @"SATURDAY", @"SUNDAY", nil];
    
    dayArray = [NSArray arrayWithObjects:@"MON", @"TUE", @"WED", @"THU",@"FRI", @"SAT", @"SUN", nil];
    
    LocationCheckArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i < [DetailsData count]; i++) {
        [LocationCheckArr addObject:[NSNumber numberWithBool:NO]];
    }
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 1402)];
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
    for(int i = 0; i < LocationCheckArr.count ;i++ )
    {
        BOOL Flag = [[LocationCheckArr objectAtIndex:i] boolValue];
        if (Flag == true) {
            locationType = [NSString stringWithFormat:@"%@%@,",locationType,[dayArray objectAtIndex:i]];
            [appDelegate.locationDict setObject:locationType forKey:@"available_days"];
        } else {
            
        }
    }
    if (locationType == nil || [locationType isKindOfClass:[NSNull class]]) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showNotice:self title:nil subTitle:@"Select Week Day." closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    NSDateFormatter *timeformatter = [[NSDateFormatter alloc]init];
    [timeformatter setDateFormat:@"hh:mm a"];
    NSString *startTime1 = [timeformatter stringFromDate:startTimeDatePicker.date];
    NSString *endTime1 = [timeformatter stringFromDate:endTimeDatePicker.date];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"MMM dd"];
    NSString *startDate1 = [dateformatter stringFromDate:startDatePicker.date];
    NSString *endDate1= [dateformatter stringFromDate:endDatePicker.date];
    
    
    [appDelegate.locationDict setObject:startTime1 forKey:@"start_time"];
    [appDelegate.locationDict setObject:endTime1 forKey:@"end_time"];
    [appDelegate.locationDict setObject:endDate1 forKey:@"start_date"];
    [appDelegate.locationDict setObject:startDate1 forKey:@"end_date"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"TimeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:390];
    cellLb.text = [DetailsData objectAtIndex:indexPath.row];
    
    BOOL selectFlag = [[LocationCheckArr objectAtIndex:indexPath.row] boolValue];
    UIButton*        cellCheckBtn = (UIButton*) [cell viewWithTag:391];
    if (selectFlag == true) {
        cellCheckBtn.selected = YES;
    } else {
        cellCheckBtn.selected = NO;
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

- (IBAction)startTime:(UIDatePicker *)sender {
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
//    [dateformatter setDateFormat:@"hh:mm"];
//    startTime = [dateformatter stringFromDate:sender.date];
//    [appDelegate.locationDict setObject:startTime forKey:@"StartTime"];
}

- (IBAction)endTime:(UIDatePicker *)sender {
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
//    [dateformatter setDateFormat:@"hh:mm"];
//    startTime = [dateformatter stringFromDate:sender.date];
//    [appDelegate.locationDict setObject:startTime forKey:@"EndTime"];
}

- (IBAction)endDate:(UIDatePicker *)sender {
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
//    [dateformatter setDateFormat:@"MMM dd"];
//    endTime = [dateformatter stringFromDate:sender.date];
//    [appDelegate.locationDict setObject:endTime forKey:@"EndDate"];
}

- (IBAction)startdate:(UIDatePicker *)sender {
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
//    [dateformatter setDateFormat:@"MMM dd"];
//    startDate = [dateformatter stringFromDate:sender.date];
//    [appDelegate.locationDict setObject:startDate forKey:@"StartDate"];
}

@end
