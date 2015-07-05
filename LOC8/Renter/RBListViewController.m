//
//  RBListViewController.m
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "RBListViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ListItem.h"
#import "RBListTableViewCell.h"
#import "ActivityIndicator.h"
#import "UIImage+ImageEffects.h"

#import "FilterNavViewController.h"
#import "SettingsMainViewController.h"
#import "SettingsNAvViewController.h"
#import "RBFilterViewController.h"
//#import "BookingNavViewController.h"
#import "LocationViewController.h"
#import "SettingHostProViewController.h"
#import "HostProNavViewController.h"
#import "ViewController.h"

#import "AppSwitchViewController.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003


@interface RBListViewController ()

@end

@implementation RBListViewController

@synthesize ListViewBtn, MapViewBtn, FavoriteViewBtn, FilterBtn;
@synthesize mapView;
@synthesize SettingsBtn, RefreshBtn;
@synthesize tbl_listView, addBlurViewToAddPlot, BlurImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self SelectListViewBtn:Nil];
    FavFlag = 0;
 
    listTxt1 = [NSArray arrayWithObjects:@"West LA1", @"West LA2", nil];
    
    listTxt2 = [NSArray arrayWithObjects:@"Modern Private Loft Studio1", @"Modern Private Loft Studio2", nil];
    
    listTxt3 = [NSArray arrayWithObjects:@"$25 per hour", @"$35 per hour", nil];
    
    listImg1 = [NSArray arrayWithObjects:@"room1", @"room1", nil];
    
    listArray = [[NSMutableArray alloc] init];
    
   [self searchListWithFiterItem:1];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectListViewBtn:(id)sender {
    
    ListViewBtn.selected    =   YES;
    MapViewBtn.selected     =   NO;
    
    mapView.hidden          =   YES;
    tbl_listView.hidden     =   NO;
}

- (IBAction)SelectMapViewBtn:(id)sender {
    
    ListViewBtn.selected    =   NO;
    MapViewBtn.selected     =   YES;
    
    mapView.hidden          =   NO;
    tbl_listView.hidden     =   YES;
}

- (IBAction)SelectFavoritesBtn:(id)sender {
    
    if (FavFlag == 0) {
        
        FavoriteViewBtn.selected    =   YES;
        FavFlag = 1;
        
    } else {
        
        FavoriteViewBtn.selected    =   NO;
        FavFlag = 0;
    }
    
    [tbl_listView reloadData];
}

- (IBAction)PushingBlurView:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self AddBlurView];
    });
}

- (void) searchListWithFiterItem: (int)tag {

    
//   [[ActivityIndicator currentIndicator] show];
}


- (UIImage*) convertImageToGrayScale:(UIImage*) image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

- (void)AddBlurView {

    
    AppSwitchViewController *popupview = (AppSwitchViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"AppSwitchController"];
    
    popupview.view.backgroundColor = [UIColor clearColor];
    UIImage *img = [self convertImageToGrayScale:[UIImage imageForView:self.tabBarController.view]];
    
    popupview.blurImage.image = [UIImage imageWithBlurImage:img];
    
    //    popupview.superViewController = self;
//    popupview.view.frame = CGRectMake(0, self.tabBarController.view.frame.size.height, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height);
    
    popupview.view.frame = CGRectMake(0, 0, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height);

    [self.tabBarController.view addSubview:popupview.view];
    [self.tabBarController addChildViewController:popupview];
    
    //    blurBGView.image = [UIImage imageWithBlurView:self.view];
    //
    //    blurBGView.alpha = 0;
    //    blurBGView.hidden = NO;
    //
    //    self.popupview = matchView;
    
    popupview.view.alpha = 0.0f;
    [UIView animateWithDuration:0 animations:^{
        //        blurBGView.alpha = 1;
//        
//        popupview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        popupview.view.alpha = 1.0f;
    }];
}

#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return [listArray count];
    
    if (FavFlag == 1) {
        return 3;
    } else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:150/256.0 blue:0/256.0 alpha:1.0];
    
    RBListTableViewCell *cell = (RBListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    if (cell == nil) {
        cell = [[RBListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    
    int pubLevelx = (int) indexPath.row % 2;
    
    
    cell.ItemList1.text     = [listTxt1 objectAtIndex:pubLevelx];
    cell.ItemList2.text     = [listTxt2 objectAtIndex:pubLevelx];
    cell.ItemList3.text     = [listTxt3 objectAtIndex:pubLevelx];
    
//    cell.ItemFavHostBtn.tag = item.ItemList_ID;
    
    [cell.ItemImg1 setImage:[UIImage imageNamed: @"tbl_cellRoom1"]];
    [cell.ItemImg2 setImage:[UIImage imageNamed: @"photo1"]];
    
    if (FavFlag == 1) {
        cell.ItemFavHostBtn.hidden = NO;
    } else {
        
        if (pubLevelx == 1) {
            cell.ItemFavHostBtn.hidden = YES;
        } else {
            cell.ItemFavHostBtn.hidden = NO;
        }
        
    }
    
    cell.ItemImg2.layer.cornerRadius    = cell.ItemImg2.frame.size.width / 2;
    cell.ItemImg2.clipsToBounds =   YES;
    
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    
    [cell.ItemImg2 setUserInteractionEnabled:YES];
    [cell.ItemImg2 addGestureRecognizer:photoTap];
    
    return cell;
}

- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"click button");
    
    userFlag = 2;
    
    [self.tabBarController.tabBar setHidden:YES];
    
//    HostProNavViewController *view1 = [self.storyboard instantiateViewControllerWithIdentifier:@"HostProNavController"];
//    
//    [self presentViewController:view1 animated:YES completion:nil];
    
    // slide left
    SettingHostProViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingHostProController"];
    
    if (PersonLoginFlag == 1) {
        view.viewFlag = 0;
    } else {
        view.viewFlag = 1;
    }
    
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.tabBarController.tabBar setHidden:YES];
    
//    BookingNavViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"BookingNavController"];

//    [self presentViewController:view animated:YES completion:nil];
    
    LocationViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationController"];
    
    [self.navigationController pushViewController:view animated:YES];
}

// Going View16 - Settings
- (IBAction)goFilter:(id)sender {
    
//    FilterNavViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterNavController"];
    
//    [self presentViewController:view animated:YES completion:nil];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    RBFilterViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"RBFilterController"];
    [self.navigationController pushViewController:view animated:YES];
    
}

// Going View22 - Settings
- (IBAction)goSettins:(id)sender {
    
    
    userFlag = 1;
    
//    SCLAlertView *alert = [[SCLAlertView alloc] init];

    
    if (PersonLoginFlag == 0) {
        
//        [alert showNotice:self title:NoticeType subTitle:STPleaseLogin closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        ViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self presentViewController:view animated:YES completion:nil];
        
    } else {
    
        SettingsNAvViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsNAvController"];
        
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:NO];
    
    if (appSideViewFlag == 0) {
        
        [self AddBlurView];
        appSideViewFlag = 1;
    }
 
}



//- (void)ButtonSelected:(UIButton *)sendor {
//
//    for(int i=0; i<=2;i++) {
//        
//        UIButton *TouchButton = (UIButton *) sendor;
//        int TouchButtonTag = (int) [TouchButton tag];
//        
//        if (i == TouchButtonTag) {
//            TouchButton.selected = YES;
//        } else {
//            TouchButton.selected = NO;
//        }
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
