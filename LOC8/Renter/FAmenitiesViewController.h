//
//  FAmenitiesViewController.h
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAmenitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *AmenitiesData;
    NSMutableArray  *CheckList;
}

@end
