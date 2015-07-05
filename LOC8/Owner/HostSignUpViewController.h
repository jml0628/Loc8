//
//  HostSignUpViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostSignUpViewController : UIViewController  <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UITextFieldDelegate>  {
    
    UIImagePickerController* imagePicker;
    NSArray *DetailsData;
}

@property (weak, nonatomic) IBOutlet UIImageView *userPic;

@property (nonatomic, weak) IBOutlet UITextField *bankTxt;
@property (nonatomic, weak) IBOutlet UITextField *routingTxt;

@end
