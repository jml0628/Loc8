//
//  LocationManageViewController.h
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
#import "AFNetworking.h"
@interface LocationManageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSArray *DetailsData;
    NSMutableArray *roomImages;
    
    int     textfeildOriginY;
    IBOutlet UIScrollView*      myRegScroller;
    
    UIImagePickerController* imagePicker;
    
    //---------------------------------------
    UIImage *locationImage;
    SCLAlertView *alert;
    
    NSMutableArray *dataArray;
}
@property (strong,nonatomic) NSString *string;
@property (nonatomic, weak) IBOutlet UITextField *LocationNameTx;
@property (nonatomic, weak) IBOutlet UITextField *NeighTx;
@property (nonatomic, weak) IBOutlet UITextField *PriceTx;

@property (nonatomic, weak) IBOutlet UIView         *DoneView;
@property (nonatomic, weak) IBOutlet UIButton       *DoneBtn;

@property (weak, nonatomic) IBOutlet UIButton *AddPhotosBtn;

@property (retain, nonatomic) IBOutlet UICollectionView *room_coll;
@property (retain, nonatomic) IBOutlet UIView           *rooms_views;
@property (retain, nonatomic) IBOutlet UIView           *main_views;


- (IBAction)addLocationAction:(id)sender;
@end
