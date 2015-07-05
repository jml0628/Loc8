//
//  TabLocationViewController.m
//  LOC8
//
//  Created by QQQ on 6/14/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "TabLocationViewController.h"
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
#import "NavOwnerAddLocViewController.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface TabLocationViewController ()

@end

@implementation TabLocationViewController

@synthesize tbl_listView, AddLocationBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listTxt1 = [NSArray arrayWithObjects:@"Modern Private Loft Studio1", @"Modern Private Loft Studio2", nil];
    
    listTxt2 = [NSArray arrayWithObjects:@"May 25th, 8PM-10PM", @"Jun 25th, 7PM-8PM", nil];
    
    listTxt3 = [NSArray arrayWithObjects:@"123 Street #910", @"321 Street #060", nil];
    listTxt4 = [NSArray arrayWithObjects:@"SF, CA 94108", @"SF, CA 56894", nil];
    
    listImg1 = [NSArray arrayWithObjects:@"room1", @"room1", nil];
    
    listArray = [[NSMutableArray alloc] init];
    
    [self searchListWithFiterItem:1];
    
    listCount = 3;
}

- (IBAction)PushingBlurView:(id)sender {
    
    [self AddBlurView];
}

- (IBAction)PushAddLocation:(id)sender {
    
    NavOwnerAddLocViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NavOwnerAddLocController"];
    
    [self presentViewController:view animated:YES completion:nil];
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
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:150/256.0 blue:0/256.0 alpha:1.0];
    
    RBMyBookingTableViewCell *cell = (RBMyBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLocationCell"];
    
    if (cell == nil) {
        cell = [[RBMyBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyLocationCell"];
    }
    
    int pubLevelx = (int) indexPath.row % 2;
    
        cell.ItemList1.text     = [listTxt1 objectAtIndex:pubLevelx];
        cell.ItemList2.text     = [listTxt2 objectAtIndex:pubLevelx];
        cell.ItemList3.text     = [listTxt3 objectAtIndex:pubLevelx];
        cell.ItemList4.text     = [listTxt4 objectAtIndex:pubLevelx];
        
        //    cell.ItemFavHostBtn.tag = item.ItemList_ID;
        
        if (TypeKind == 0) {
            
            cell.ItemBtn1.hidden = NO;
        } else
            cell.ItemBtn1.hidden = YES;
        
        [cell.ItemImg1 setImage:[UIImage imageNamed: @"tbl_cellRoom1.png"]];
        
        
        cell.ItemImg2.hidden    =   YES;
        
        [cell.ItemBtn2 addTarget:self action:@selector(GoremoveLocation:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ItemBtn1 addTarget:self action:@selector(GoEditList:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)GoremoveLocation:(UIButton*)sender {
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert addButton:@"Done" actionBlock:^(void) {
        NSLog(@"Second button tapped");
        
        listCount = listCount - 1;
        
        [self.tbl_listView reloadData];
        
//        [alert showNotice:self title:kNoticeTitle subTitle:@"You've just displayed this awesome Pop Up View with 5 seconds duration" closeButtonTitle:nil duration:0.2f];
    }];
    
    [alert showSuccess:self title:@"Remove listing" subTitle:@"Are you sure you want to remove this listing?" closeButtonTitle:@"Close" duration:0.0f];

    
    
    
    return;
}

- (void)GoEditList:(UIButton*)sender {
    
    NavOwnerAddLocViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NavOwnerAddLocController"];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (TypeKind == 0) {
        return 138;
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
    }];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
