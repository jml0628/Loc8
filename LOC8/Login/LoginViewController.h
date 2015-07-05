//
//  LoginViewController.h
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextField *UsernameTxt;
@property (strong, nonatomic) IBOutlet UITextField *EmailTxt;
@property (strong, nonatomic) IBOutlet UITextField *FistNameTxt;
@property (strong, nonatomic) IBOutlet UITextField *LastNameTxt;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTxt;

@property (nonatomic,retain) NSMutableData*     responseData;


@end
