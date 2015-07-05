//
//  WeightViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, weak) IBOutlet UITextField *PoundsTx;
@property (nonatomic, weak) IBOutlet UIButton    *saveBtn;

@end
