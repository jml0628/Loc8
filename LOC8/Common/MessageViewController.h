//
//  MessageViewController.h
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIScrollView*      myRegScroller;
}

@property (nonatomic) int                 goneFlag;

@property (nonatomic, strong) IBOutlet UITextField *PersonMessageTxt;
@property (nonatomic, weak) IBOutlet UIButton       *sendBtn;

@property (nonatomic, weak) IBOutlet UIView         *tmpView;


@end
