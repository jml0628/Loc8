//
//  ForgotPasswdViewController.h
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswdViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UITextField *FPUsername;

@property (nonatomic,retain) NSMutableData*     responseData;

@end
