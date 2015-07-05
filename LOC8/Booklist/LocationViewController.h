//
//  LocationViewController.h
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UIScrollViewDelegate>  {
    
    IBOutlet UIScrollView*      myRegScroller;
    IBOutlet UIView*            roomsView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollRoomView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageroomControl;

@property (nonatomic, strong) IBOutlet UIImageView*   OwnerSmallPic;
@property (nonatomic, strong) IBOutlet UIImageView*   OwnerWidePic;

@end
