//
//  AddTimeViewController.h
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"

@interface AddTimeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSArray *DetailsData,*dayArray;
    
    IBOutlet UIScrollView*      myRegScroller;
    
    NSString *startTime,*endTime,*startDate,*endDate;
    IBOutlet UIDatePicker *startTimeDatePicker,*endTimeDatePicker,*startDatePicker,*endDatePicker;
    
    //-----------------------
    NSMutableArray  *LocationCheckArr;
}
- (IBAction)startTime:(UIDatePicker *)sender;
- (IBAction)endTime:(UIDatePicker *)sender;


- (IBAction)startdate:(UIDatePicker *)sender;
- (IBAction)endDate:(UIDatePicker *)sender;

@end
