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
#import "AppDelegate.h"
#import "PApiCall.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface TabLocationViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation TabLocationViewController

@synthesize tbl_listView, AddLocationBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [AppDelegate sharedDelegate];
    
    dataArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    listTxt1 = [[NSArray alloc]init]; // [NSArray arrayWithObjects:@"Modern Private Loft Studio1", @"Modern Private Loft Studio2", nil];
    listTxt2 = [[NSArray alloc]init]; //[NSArray arrayWithObjects:@"May 25th, 8PM-10PM", @"Jun 25th, 7PM-8PM", nil];
    listTxt3 = [[NSArray alloc]init]; // [NSArray arrayWithObjects:@"123 Street #910", @"321 Street #060", nil];
    listTxt4 = [[NSArray alloc]init]; //[NSArray arrayWithObjects:@"SF, CA 94108", @"SF, CA 56894", nil];
    
    listImg1 = [[NSArray alloc]init]; //[NSArray arrayWithObjects:@"room1", @"room1", nil];
    
    listArray = [[NSMutableArray alloc]init]; //[[NSMutableArray alloc] init];
    
    [self searchListWithFiterItem:1];
    
    listCount = 3;
   
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self getData];
}

- (void) getData
{
    NSString *userId= appDelegate.userKey;
    [dataArray removeAllObjects];
    [[ActivityIndicator currentIndicator] show];
    
    [[PApiCall sharedInstance]m_GetApiResponse:Host_Url parameters:[NSString stringWithFormat:@"mode=GetLocation&user_id=%@",userId] onCompletion:^(NSDictionary *json) {
        NSLog(@"%@",json);
        [[ActivityIndicator currentIndicator] hide];
        if([[json valueForKey:@"value"] isKindOfClass:[NSArray class]])
        {
       [ dataArray addObjectsFromArray:[json valueForKey:@"value"]];
        }
        [tbl_listView reloadData];
    }];
}
- (IBAction)PushingBlurView:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)PushAddLocation:(id)sender {
    appDelegate.updateString = @"Add";
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
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:150/256.0 blue:0/256.0 alpha:1.0];
    
    RBMyBookingTableViewCell *cell = (RBMyBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLocationCell"];
    
    if (cell == nil) {
        cell = [[RBMyBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyLocationCell"];
    }
        cell.ItemList1.text     = [NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"location_name"]];
    NSString *dateString = [NSString stringWithFormat:@"%@ %@ - %@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"start_date"],[[dataArray objectAtIndex:indexPath.row]valueForKey:@"start_time"],[[dataArray objectAtIndex:indexPath.row]valueForKey:@"end_time"]];
        cell.ItemList2.text     = dateString;
        cell.ItemList3.text     = [[dataArray objectAtIndex:indexPath.row]valueForKey:@"address"];
        cell.ItemList4.text     = [NSString stringWithFormat:@"%@ ,%@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"ATP"],[[dataArray objectAtIndex:indexPath.row]valueForKey:@"city"]];
        
        //    cell.ItemFavHostBtn.tag = item.ItemList_ID;
        
        if (TypeKind == 0) {
            
            cell.ItemBtn1.hidden = NO;
        } else
            cell.ItemBtn1.hidden = YES;
    
    NSString *URL = [[dataArray objectAtIndex:indexPath.row]valueForKey:@"image_data"];
   if (URL == nil || [URL isKindOfClass:[NSNull class]]) {
       
    } else {
        [cell.ItemImg1 setImageURL:[NSURL URLWithString:@""]];
        [cell.ItemImg1 setImageURL:[NSURL URLWithString:URL]];
    }
    cell.ItemImg2.hidden    =   YES;
        
    [cell.ItemBtn2 addTarget:self action:@selector(GoremoveLocation:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ItemBtn1 addTarget:self action:@selector(GoEditList:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.ItemBtn1.tag = indexPath.row;
    cell.ItemBtn2.tag = indexPath.row;
    return cell;
}

- (void)GoremoveLocation:(UIButton*)sender {
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert addButton:@"Done" actionBlock:^(void) {
        
        
        NSString *locationId = [[dataArray objectAtIndex:sender.tag]valueForKey:@"location_id"];
        [[ActivityIndicator currentIndicator] show];
        [[PApiCall sharedInstance]m_GetApiResponse:Host_Url parameters:[NSString stringWithFormat:@"mode=DeleteLocation&location_id=%@",locationId] onCompletion:^(NSDictionary *json) {
            NSLog(@"%@",json);
            [[ActivityIndicator currentIndicator] hide];
            if([[json valueForKey:@"value"] isKindOfClass:[NSArray class]])
            {
                [ dataArray addObjectsFromArray:[json valueForKey:@"value"]];
            }
            [tbl_listView reloadData];
        }];
        [self getData];
    }];
    
    [alert showSuccess:self title:@"Remove listing" subTitle:@"Are you sure you want to remove this listing?" closeButtonTitle:@"Close" duration:0.0f];
    return;
}

- (void)GoEditList:(UIButton*)sender {

    appDelegate.updateId = [[dataArray objectAtIndex:sender.tag]valueForKey:@"location_id"];
    appDelegate.updateString = @"update";
    NavOwnerAddLocViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NavOwnerAddLocController"];
    [self presentViewController:view animated:YES completion:nil];

//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    [alert addButton:@"Done" actionBlock:^(void) {
//        appDelegate.updateId = [[dataArray objectAtIndex:sender.tag]valueForKey:@"location_id"];
//        appDelegate.updateString = @"update";
//        NavOwnerAddLocViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NavOwnerAddLocController"];
//        [self presentViewController:view animated:YES completion:nil];
//    }];
//    
//    [alert showSuccess:self title:@"Remove listing" subTitle:@"Are you sure you want to edit this listing?" closeButtonTitle:@"Close" duration:0.0f];
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
