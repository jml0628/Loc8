//
//  SignUpViewController.h
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UITextField *UsernameTxt;
@property (nonatomic, strong) IBOutlet UITextField *EmailTxt;
@property (nonatomic, strong) IBOutlet UITextField *FirstnameTxt;
@property (nonatomic, strong) IBOutlet UITextField *LastnameTxt;
@property (nonatomic, strong) IBOutlet UITextField *PassTxt;

@property (nonatomic,retain) NSMutableData*     responseData;

@end
