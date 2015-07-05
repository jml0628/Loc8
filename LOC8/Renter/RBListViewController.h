//
//  RBListViewController.h
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface RBListViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    NSArray *listTxt1;
    NSArray *listTxt2;
    NSArray *listTxt3;
    
    NSArray *listImg1;
    NSArray *listImg2;
    
    NSMutableData*     responseData;
    
    NSMutableArray*     listArray;
    
    int         curConnectionState;
    
    int     FavFlag;
    int     didBlurFlag;
}

@property(nonatomic,retain)IBOutlet MKMapView *mapView;

@property (nonatomic, strong) IBOutlet UIButton *ListViewBtn;
@property (nonatomic, strong) IBOutlet UIButton *MapViewBtn;
@property (nonatomic, strong) IBOutlet UIButton *FavoriteViewBtn;
@property (nonatomic, strong) IBOutlet UIButton *FilterBtn;

@property (nonatomic, strong) IBOutlet UIButton *RefreshBtn;
@property (nonatomic, strong) IBOutlet UIButton *SettingsBtn;

@property (strong, nonatomic) IBOutlet  UITableView* tbl_listView;

@property (weak, nonatomic) IBOutlet UIView         *addBlurViewToAddPlot;
@property (weak, nonatomic) IBOutlet UIImageView    *BlurImage;


@end
