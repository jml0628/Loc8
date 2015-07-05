//
//  ViewController.h
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController {
    
}

@property ( nonatomic, retain) IBOutlet UIButton    *LoginBtn;
@property ( nonatomic, retain) IBOutlet UIButton    *SignUpBtn;

@property (nonatomic,  retain) IBOutlet UIView      *bottomView;
@property (nonatomic,  retain) IBOutlet UIImageView *backgroundIamge;

@property (nonatomic,  retain) IBOutlet UIImageView *loc8TitleIamge;

@property (nonatomic,  retain) IBOutlet UIView      *loadingView;
@property (nonatomic,  retain) IBOutlet UIImageView *loadingIcon;
@property (nonatomic,  retain) IBOutlet UILabel *loadingTxt;

@end

