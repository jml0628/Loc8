//
//  RBFilterViewController.h
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBFilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *DetailsData;

}

@property (nonatomic) int       tmpfilterZipCode;
@property (nonatomic) NSArray*  tmpfilerLocationType;
@property (nonatomic) NSArray*  tmpfilerAmenities;


@property (nonatomic) int FilterRadius;



@property (nonatomic, strong) IBOutlet UIButton *Miles2Btn;
@property (nonatomic, strong) IBOutlet UIButton *Miles5Btn;
@property (nonatomic, strong) IBOutlet UIButton *Miles25Btn;

@property (nonatomic, strong) IBOutlet UISwitch *FabSwitchBtn;

@end
