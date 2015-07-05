//
//  RentersViewController.h
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
    
    NSArray *listTxt1;
    NSArray *listTxt2;
    NSArray *listTxt3;
    NSArray *listTxt4;
    
    NSArray *listImg1;
    NSArray *listImg2;
    
    NSMutableData*     responseData;
    
    NSMutableArray*     listArray;
    
    int         curConnectionState;
    
    int     TypeKind1;
}

@property (nonatomic, strong) IBOutlet UIButton *UpcomingBtn;
@property (nonatomic, strong) IBOutlet UIButton *PreviousBtn;

@property (strong, nonatomic) IBOutlet  UITableView* tbl_listView;

@end
