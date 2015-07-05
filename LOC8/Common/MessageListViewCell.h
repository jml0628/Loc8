//
//  MessageListViewCell.h
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel*     ItemList1;
@property (strong, nonatomic) IBOutlet UILabel*     ItemList2;
@property (strong, nonatomic) IBOutlet UILabel*     ItemList3;

@property (strong, nonatomic) IBOutlet UIImageView* ItemImg1;
@property (strong, nonatomic) IBOutlet UIImageView* ItemImg2;

@end
