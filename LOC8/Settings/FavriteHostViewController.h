//
//  FavriteHostViewController.h
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavriteHostViewController : UIViewController
{
    int favSelectFlag;
}

@property (nonatomic, weak) IBOutlet UIImageView *PersonPhoto;
@property (nonatomic, weak) IBOutlet UIButton *FabBtn;

@end
