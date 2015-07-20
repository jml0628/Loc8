//
//  ADLHourViewController.h
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ADLHourViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *LocationArrData;
    IBOutlet UITableView *availibiltyTable;
    
}


@end
