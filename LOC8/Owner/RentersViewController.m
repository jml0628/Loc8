//
//  RentersViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "RentersViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"
#import "UIImage+ImageEffects.h"

#import "RBMyBookingTableViewCell.h"
#import "SettingsMainViewController.h"
#import "SettingsNAvViewController.h"
#import "AppSwitchNavViewController.h"
#import "AppSwitchViewController.h"
#import "MessageViewController.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface RentersViewController ()

@end

@implementation RentersViewController
@synthesize UpcomingBtn, PreviousBtn;
@synthesize tbl_listView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self PushUpcoming:Nil];
    TypeKind1 = 0;
    
    //    AppSideSwitcherViewController *subCtrl = [[AppSideSwitcherViewController alloc] initWithNibName:@"AppSideSwitcherController" bundle:nil];
    //
    //    subCtrl.view.frame = self.addViewToAddPlot.bounds;
    //    [self.addViewToAddPlot addSubview:subCtrl.view];
    //    [subCtrl didMoveToParentViewController:self];
    //    [self addChildViewController:subCtrl];
    
    listTxt1 = [NSArray arrayWithObjects:@"Modern Private Loft Studio1", @"Modern Private Loft Studio2", nil];
    
    listTxt2 = [NSArray arrayWithObjects:@"May 25th, 8PM-10PM", @"Jun 25th, 7PM-8PM", nil];
    
    listTxt3 = [NSArray arrayWithObjects:@"123 Street #910", @"321 Street #060", nil];
    listTxt4 = [NSArray arrayWithObjects:@"SF, CA 94108", @"SF, CA 56894", nil];
    
    listImg1 = [NSArray arrayWithObjects:@"room1", @"room1", nil];
    
    listArray = [[NSMutableArray alloc] init];
    
    [self searchListWithFiterItem:1];
}

- (IBAction)PushingBlurView:(id)sender {
    
    [self AddBlurView];
}

- (IBAction)PushUpcoming:(id)sender {
    
    UpcomingBtn.selected    =   YES;
    PreviousBtn.selected    =   NO;
    
    TypeKind1 = 0;
    [tbl_listView reloadData];
}

- (IBAction)PushPrevious:(id)sender {
    
    UpcomingBtn.selected    =   NO;
    PreviousBtn.selected    =   YES;
    
    TypeKind1 = 1;
    [tbl_listView reloadData];
}

// Going View22 - Settings
- (IBAction)goSettins:(id)sender {
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if (PersonLoginFlag == 0) {
        
        [alert showNotice:self title:NoticeType subTitle:STPleaseLogin closeButtonTitle:CloseButtonTitle duration:0.0f];
    } else {
        
        SettingsNAvViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsNAvController"];
        
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (void) searchListWithFiterItem: (int)tag {
    
    
    //   [[ActivityIndicator currentIndicator] show];
}

#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (TypeKind1 == 0) {
        return 2;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return [listArray count];
    
    if (TypeKind1 == 0) {
        
        if (section == 0) {
            return 3;
        } else {
            return 0;
        }
    } else {
        return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:150/256.0 blue:0/256.0 alpha:1.0];
    
    RBMyBookingTableViewCell *cell = (RBMyBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyRentersCell"];
    
    if (cell == nil) {
        cell = [[RBMyBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyRentersCell"];
    }
    
    int pubLevelx = (int) indexPath.row % 2;
    
    
        cell.ItemList1.text     = [listTxt1 objectAtIndex:pubLevelx];
        cell.ItemList2.text     = [listTxt2 objectAtIndex:pubLevelx];
        cell.ItemList3.text     = [listTxt3 objectAtIndex:pubLevelx];
        cell.ItemList4.text     = [listTxt4 objectAtIndex:pubLevelx];
        
        //    cell.ItemFavHostBtn.tag = item.ItemList_ID;
        
        cell.ItemBtn1.hidden = NO;
        
        [cell.ItemImg1 setImage:[UIImage imageNamed: @"tbl_cellRoom1.png"]];
        [cell.ItemImg2 setImage:[UIImage imageNamed: @"temp_renters1.png"]];
    
    if (TypeKind1 == 1) {
        cell.ItemBtn1.hidden    =   YES;
        cell.ItemImg2.hidden    =   YES;
        
        cell.ItemList5.hidden   = YES;
        cell.ItemList6.hidden   = YES;
        cell.ItemList7.hidden   = YES;
        cell.ItemList8.hidden   = YES;
        
    } else {
        cell.ItemBtn1.hidden    =   NO;
        cell.ItemImg2.hidden    =   NO;
        
        cell.ItemList5.hidden   = NO;
        cell.ItemList6.hidden   = NO;
        cell.ItemList7.hidden   = NO;
        cell.ItemList8.hidden   = NO;
    }
        
        [cell.ItemBtn1 addTarget:self action:@selector(GoMessageView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)GoMessageView:(UIButton*)sender {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    MessageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
    
    [self.navigationController pushViewController:view animated:YES];
//    [self presentViewController:view animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:NO];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (TypeKind1 == 0) {
        return 173;
    } else
        return  93;
}

- (void)aMethod:(UIButton*)sener {
    NSLog(@"click button");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [UIView animateWithDuration:0.0 animations:^{
        //        blurBGView.alpha = 1;
        //
        //        popupview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        popupview.view.alpha = 1.0f;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
