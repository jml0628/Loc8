//
//  SettingsMainViewController.h
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsMainViewController : UIViewController < UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>  {
    
    UIImagePickerController* imagePicker;
    
    NSArray *DetailsData;
    NSArray *HostInfoData;
    NSArray *OtherSetData;
    
    IBOutlet UIScrollView*      myRegScroller;
}

@property (nonatomic, strong) IBOutlet UIButton *LogoutBtn;

@property (weak, nonatomic) IBOutlet UIImageView *userPic;

@property (nonatomic, strong) IBOutlet UITableView *tbl_detail;
@property (nonatomic, strong) IBOutlet UITableView *tbl_hostInfo;
@property (nonatomic, strong) IBOutlet UITableView *tbl_otherSet;

@property (nonatomic, weak) IBOutlet UITextField *firstName;
@property (nonatomic, weak) IBOutlet UITextField *lasttName;
@property (nonatomic, weak) IBOutlet UITextField *emailName;

@end
