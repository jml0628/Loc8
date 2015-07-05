//
//  GoMessageViewController.h
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoMessageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
    
    NSArray *listTxt1;
    NSArray *listTxt2;
    NSArray *listTxt3;
    
    NSArray *listImg1;
    NSArray *listImg2;
    
    NSMutableData*     responseData;
    
    NSMutableArray*     listArray;
    
    int         curConnectionState;
}

@end
