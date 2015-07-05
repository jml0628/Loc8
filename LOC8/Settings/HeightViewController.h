//
//  HeightViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeightViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, weak) IBOutlet UITextField *FeetTx;
@property (nonatomic, weak) IBOutlet UITextField *InchesTx;

@property (nonatomic, weak) IBOutlet UIButton    *SaveBtn;

@end
