//
//  BookRoomDatesViewController.h
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface BookRoomDatesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, JTCalendarDataSource> {
    
    IBOutlet UIScrollView*      myRegScroller;
    
    NSMutableArray *TempSelArrTimeList;
    NSMutableArray *ArrTimeList;
    
    NSMutableArray *SelArrTimeList;
    NSMutableArray *SelArrTimeList2;

}

@property (nonatomic, weak) IBOutlet UIView *ArrDateView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;


@property (nonatomic, weak) IBOutlet UICollectionView *ArrTimeView;

@property (nonatomic, weak) IBOutlet UIView *DepDateView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView2;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView2;

@property (nonatomic, weak) IBOutlet UICollectionView *DepTimeView;

@property (strong, nonatomic) JTCalendar *calendar;
@property (strong, nonatomic) JTCalendar *calendar2;

@end
