//
//  RBListTableViewCell.m
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "RBListTableViewCell.h"


@implementation RBListTableViewCell

@synthesize ItemImg1, ItemImg2, ItemList1, ItemList2, ItemList3;
@synthesize ItemFavHostBtn;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
