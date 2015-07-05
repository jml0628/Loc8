//
//  AddCardViewController.h
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCardViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextField *CardNumTxt;
@property (strong, nonatomic) IBOutlet UITextField *CVVTxt;
@property (strong, nonatomic) IBOutlet UITextField *ExpTxt;

@end
