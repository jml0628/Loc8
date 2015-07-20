//
//  AppDelegate.h
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableDictionary *locationDict;
@property (strong,nonatomic) NSString *updateString;
@property (strong,nonatomic) NSString *updateId;
@property (strong,nonatomic) NSString *userKey;
+(AppDelegate *)sharedDelegate;
@end

