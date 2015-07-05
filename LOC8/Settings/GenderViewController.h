//
//  GenderViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *DetailsData;
    int     GenderType;
}

@property (nonatomic, weak) IBOutlet UIButton *saveBtn;


@end
