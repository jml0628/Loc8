//
//  ADLAddViewController.h
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLAddViewController : UIViewController <UITextFieldDelegate> {
    
    
}

@property (nonatomic, weak) IBOutlet UITextField *Address1Txt;
@property (nonatomic, weak) IBOutlet UITextField *Address2Txt;
@property (nonatomic, weak) IBOutlet UITextField *Address3Txt;
@property (nonatomic, weak) IBOutlet UITextField *Address4Txt;
@property (nonatomic, weak) IBOutlet UITextField *Address5Txt;

@end
