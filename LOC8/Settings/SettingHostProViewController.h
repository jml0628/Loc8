//
//  SettingHostProViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingHostProViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSArray *DetailsData;
    int     textfeildOriginY;
    
    IBOutlet UIScrollView*      myRegScroller;
}

@property (nonatomic, weak) IBOutlet UITextField    *AgeTx;
@property (nonatomic, weak) IBOutlet UILabel        *Titlelb;
@property (nonatomic, weak) IBOutlet UIButton       *SaveBtn;

@property (nonatomic, weak) IBOutlet UIView         *DoneView;
@property (nonatomic, weak) IBOutlet UIButton       *DoneBtn;

@property (nonatomic) int viewFlag;

@end
