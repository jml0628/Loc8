//
//  ADLAmenityViewController.h
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLAmenityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray         *AmenitiesData;
    NSMutableArray  *AmenitiesCheckArr;
}

@end
