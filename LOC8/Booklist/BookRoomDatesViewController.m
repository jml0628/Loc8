//
//  BookRoomDatesViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "BookRoomDatesViewController.h"
#import "BookRoomPaymentViewController.h"

#import "SelectTimeCollectionViewCell.h"


@interface BookRoomDatesViewController ()
{
    NSInteger beforeIndex;
    NSInteger beforeIndex2;
}

@end

@implementation BookRoomDatesViewController

@synthesize ArrDateView, ArrTimeView, DepDateView, DepTimeView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 1301)];
    
    ArrTimeList = [[NSMutableArray alloc] init] ;
    SelArrTimeList = [NSMutableArray arrayWithObjects:@"0",@"1",@"0",@"0",@"1",@"0",@"2",@"2",@"0",@"0",@"0",@"2",@"2",@"2",@"0",@"1",@"1",@"0",@"1",@"0",@"2",@"2",@"0",@"0", nil];
    SelArrTimeList2 = [NSMutableArray arrayWithObjects:@"0",@"1",@"1",@"0",@"0",@"2",@"",@"2",@"0",@"0",@"0",@"2",@"2",@"1",@"1",@"2",@"1",@"0",@"0",@"0",@"0",@"2",@"0",@"0", nil];
    
    for (int i=0; i<= 23; i++) {
        
        NSString *objStr = [[NSString alloc] init];
        
        if (i < 12) {
            objStr = [NSString stringWithFormat:@"%dAM", i+1];
        } else {
            objStr = [NSString stringWithFormat:@"%dPM", i+1];
        }
        
        [ArrTimeList addObject:objStr];
    }
    
    self.calendar = [JTCalendar new];
    self.calendar2 = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar2.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar2.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar2.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar2 setMenuMonthsView:self.calendarMenuView2];
    [self.calendar2 setContentView:self.calendarContentView2];
    [self.calendar2 setDataSource:self];

    
    beforeIndex = -1;
    beforeIndex2 = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoBookRoomDates:(id)sender {
    
    BookRoomPaymentViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"BookRoomPaymentController"];
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void)dayChangedToDate:(NSDate *)selectedDate
{
    NSLog(@"dayChangedToDate %@(GMT)",selectedDate);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == ArrTimeView) {
        return [ArrTimeList count];
    } else if (collectionView == DepTimeView) {
        return [ArrTimeList count];
    } else {
        return 0;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return  1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == ArrTimeView) {
        SelectTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArrTimeCell" forIndexPath:indexPath];
        
//        UIButton *cellTimeItem = (UIButton *)[cell viewWithTag:82];
        
        int AvailTimeFlag1 = [[SelArrTimeList objectAtIndex:indexPath.row] intValue];
        
        UIImage *TimeImg = [[UIImage alloc] init];
        UIColor *TimeColor = [[UIColor alloc] init];
        
        NSString *TimeStr = [NSString stringWithFormat:@"%@", [ArrTimeList objectAtIndex:indexPath.row]];
        [cell.TimeItem1 setTag:indexPath.row];
        
        
        if (AvailTimeFlag1 == 1) {
            TimeImg = [UIImage imageNamed:@"icon_calBlack"];
            TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
            cell.TimeItem1.enabled = NO;

        } else if (AvailTimeFlag1 == 2) {
            
            TimeImg = [UIImage imageNamed:@"icon_calBlue"];
            TimeColor = [UIColor whiteColor];
            [cell.TimeItem1 addTarget:self action:@selector(SelectArrTime:) forControlEvents:UIControlEventTouchUpInside];
            cell.TimeItem1.enabled = YES;
            
        } else if (AvailTimeFlag1 == 3) {
            TimeImg = [UIImage imageNamed:@"icon_calGreen"];
            TimeColor = [UIColor whiteColor];
            [cell.TimeItem1 addTarget:self action:@selector(SelectArrTime:) forControlEvents:UIControlEventTouchUpInside];
            cell.TimeItem1.enabled = YES;
            
        } else {
            TimeImg = [UIImage imageNamed:@"icon_calOutline"];
            TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
            cell.TimeItem1.enabled = NO;
        }
        
        
        [cell.TimeItem1 setTitle:TimeStr forState:UIControlStateNormal];
        [cell.TimeItem1 setBackgroundImage:TimeImg forState:UIControlStateNormal];
        [cell.TimeItem1 setTitleColor:TimeColor forState:UIControlStateNormal];
        
        return cell;
        
    } else if (collectionView == DepTimeView) {
        
        SelectTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DepTimeCell" forIndexPath:indexPath];
        
//        UIButton *cellTimeItem = (UIButton *)[cell viewWithTag:84];
        
        int AvailTimeFlag2 = [[SelArrTimeList2 objectAtIndex:indexPath.row] intValue];
        
        UIImage *TimeImg = [[UIImage alloc] init];
        UIColor *TimeColor = [[UIColor alloc] init];
        
        NSString *TimeStr = [NSString stringWithFormat:@"%@", [ArrTimeList objectAtIndex:indexPath.row]];
        [cell.TimeItem2 setTag:indexPath.row + 48];
        
        
        
        if (AvailTimeFlag2 == 1) {
            TimeImg = [UIImage imageNamed:@"icon_calBlack"];
            TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
            cell.TimeItem2.enabled = NO;
            
        } else if (AvailTimeFlag2 == 2) {
            
            TimeImg = [UIImage imageNamed:@"icon_calBlue"];
            TimeColor = [UIColor whiteColor];
            [cell.TimeItem2 addTarget:self action:@selector(SelectDepTime:) forControlEvents:UIControlEventTouchUpInside];
            cell.TimeItem2.enabled = YES;
            
        } else if (AvailTimeFlag2 == 3) {
            TimeImg = [UIImage imageNamed:@"icon_calGreen"];
            TimeColor = [UIColor whiteColor];
            [cell.TimeItem2 addTarget:self action:@selector(SelectDepTime:) forControlEvents:UIControlEventTouchUpInside];
            cell.TimeItem2.enabled = YES;
            
        } else {
            TimeImg = [UIImage imageNamed:@"icon_calOutline"];
            TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
            cell.TimeItem2.enabled = NO;
        }
        
        
        
        [cell.TimeItem2 setTitle:TimeStr forState:UIControlStateNormal];
        [cell.TimeItem2 setBackgroundImage:TimeImg forState:UIControlStateNormal];
        [cell.TimeItem2 setTitleColor:TimeColor forState:UIControlStateNormal];
        
        return cell;
    } else {
        
        return nil;
    }
 
    
}

- (void)SelectArrTime :(id) sender{
    
    
    UIButton *but = (UIButton *)sender;
    
    int butTag = (int) but.tag;
   
    NSIndexPath * beforeIndexPath = [NSIndexPath indexPathForItem:beforeIndex inSection:0];
    
    NSIndexPath * currentIndexPath = [NSIndexPath indexPathForItem:butTag inSection:0];
    
    SelectTimeCollectionViewCell * beforeCell = (SelectTimeCollectionViewCell *)[ArrTimeView cellForItemAtIndexPath:beforeIndexPath];
    
    SelectTimeCollectionViewCell * cell = (SelectTimeCollectionViewCell *)[ArrTimeView cellForItemAtIndexPath:currentIndexPath];
    
    
    NSString *ItemValue;

    
    UIImage *TimeImg = [[UIImage alloc] init];
    UIColor *TimeColor = [[UIColor alloc] init];
    
    if ([[SelArrTimeList objectAtIndex:butTag]  isEqual: @"2"]) {
        
        ItemValue =  @"3";
    } else if ([[SelArrTimeList objectAtIndex:butTag]  isEqual: @"3"]) {
        
        ItemValue = @"2";
    } else {
        ItemValue = [SelArrTimeList objectAtIndex:butTag];
    }
    
    
    [SelArrTimeList replaceObjectAtIndex:butTag withObject:ItemValue];
    
    if (beforeIndex != -1) {
        [SelArrTimeList replaceObjectAtIndex:beforeIndex withObject:@"2"];
    }
    
    
    
    if ([ItemValue  isEqual: @"1"]) {
        TimeImg = [UIImage imageNamed:@"icon_calBlack"];
        TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
        cell.TimeItem1.enabled = NO;
        
    } else if ([ItemValue  isEqual: @"2"]) {
        
        TimeImg = [UIImage imageNamed:@"icon_calBlue"];
        TimeColor = [UIColor whiteColor];
        cell.TimeItem1.enabled = YES;
        
    } else if ([ItemValue  isEqual: @"3"]) {
        
        TimeImg = [UIImage imageNamed:@"icon_calGreen"];
        TimeColor = [UIColor whiteColor];
        cell.TimeItem1.enabled = YES;
    } else {
        
        TimeImg = [UIImage imageNamed:@"icon_calOutline"];
        TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
        cell.TimeItem1.enabled = NO;
    }
    
    [cell.TimeItem1 setBackgroundImage:TimeImg forState:UIControlStateNormal];
    [cell.TimeItem1 setTitleColor:TimeColor forState:UIControlStateNormal];
    
    if (beforeIndex != -1) {
        
        [beforeCell.TimeItem1 setBackgroundImage:[UIImage imageNamed:@"icon_calBlue"] forState:UIControlStateNormal];
        [beforeCell.TimeItem1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    
    beforeIndex = butTag;
    
    
}

- (void)SelectDepTime :(id) sender{
    
    UIButton *but = (UIButton *)sender;
    
    int butTag = (int) but.tag ;
    int arrayTag = (int) but.tag - 48;
    
    NSIndexPath * beforeIndexPath2 = [NSIndexPath indexPathForItem:beforeIndex2 inSection:0];
    
    NSIndexPath * currentIndexPath2 = [NSIndexPath indexPathForItem:arrayTag inSection:0];
    
    SelectTimeCollectionViewCell * beforeCell = (SelectTimeCollectionViewCell *)[DepTimeView cellForItemAtIndexPath:beforeIndexPath2];
    
    SelectTimeCollectionViewCell * cell = (SelectTimeCollectionViewCell *)[DepTimeView cellForItemAtIndexPath:currentIndexPath2];
    
    
    NSString *ItemValue2;
    
    
    UIImage *TimeImg = [[UIImage alloc] init];
    UIColor *TimeColor = [[UIColor alloc] init];
    
    if ([[SelArrTimeList2 objectAtIndex:arrayTag]  isEqual: @"2"]) {
        
        ItemValue2 =  @"3";
    } else if ([[SelArrTimeList2 objectAtIndex:arrayTag]  isEqual: @"3"]) {
        
        ItemValue2 = @"2";
    } else {
        ItemValue2 = [SelArrTimeList2 objectAtIndex:arrayTag];
    }
    
    
    [SelArrTimeList2 replaceObjectAtIndex:arrayTag withObject:ItemValue2];
    
    if (beforeIndex2 != -1) {
        [SelArrTimeList2 replaceObjectAtIndex:beforeIndex2 withObject:@"2"];
    }
    
    
    
    if ([ItemValue2  isEqual: @"1"]) {
        TimeImg = [UIImage imageNamed:@"icon_calBlack"];
        TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
        cell.TimeItem2.enabled = NO;
        
    } else if ([ItemValue2  isEqual: @"2"]) {
        
        TimeImg = [UIImage imageNamed:@"icon_calBlue"];
        TimeColor = [UIColor whiteColor];
        cell.TimeItem2.enabled = YES;
        
    } else if ([ItemValue2  isEqual: @"3"]) {
        
        TimeImg = [UIImage imageNamed:@"icon_calGreen"];
        TimeColor = [UIColor whiteColor];
        cell.TimeItem2.enabled = YES;
    } else {
        
        TimeImg = [UIImage imageNamed:@"icon_calOutline"];
        TimeColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
        cell.TimeItem2.enabled = NO;
    }
    
    [cell.TimeItem2 setBackgroundImage:TimeImg forState:UIControlStateNormal];
    [cell.TimeItem2 setTitleColor:TimeColor forState:UIControlStateNormal];
    
    if (beforeIndex2 != -1) {
        
        [beforeCell.TimeItem2 setBackgroundImage:[UIImage imageNamed:@"icon_calBlue"] forState:UIControlStateNormal];
        [beforeCell.TimeItem2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    
    beforeIndex2 = arrayTag;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", date);
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
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
