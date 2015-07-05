//
//  TabMessageViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "TabMessageViewController.h"

#import "SCLAlertView.h"
#import "MessageViewController.h"
#import "Config.h"
#import "ActivityIndicator.h"
#import "UIImage+ImageEffects.h"

#import "MessageListViewCell.h"
#import "SettingsNAvViewController.h"
#import "AppSwitchViewController.h"

@interface TabMessageViewController ()

@end

@implementation TabMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listTxt1 = [NSArray arrayWithObjects:@"Jessica Robbin1", @"Jessica Robbin2", nil];
    
    listTxt2 = [NSArray arrayWithObjects:@"Hello! when will you be coming by?", @"The work week has ended.", nil];
    
    listTxt3 = [NSArray arrayWithObjects:@"12:15 PM", @"8:23 AM", nil];
    
    
    listImg1 = [NSArray arrayWithObjects:@"room1", @"room1", nil];
    
    listArray = [[NSMutableArray alloc] init];
    
    [self searchListWithFiterItem:1];
}

- (IBAction)PushingBlurView:(id)sender {
    
    [self AddBlurView];
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
    
    //    return [listArray count];
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:150/256.0 blue:0/256.0 alpha:1.0];
    
    MessageListViewCell *cell = (MessageListViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    
    if (cell == nil) {
        cell = [[MessageListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
    }
    
    int pubLevelx = (int) indexPath.row % 2;
    
    
    cell.ItemList1.text     = [listTxt1 objectAtIndex:pubLevelx];
    cell.ItemList2.text     = [listTxt2 objectAtIndex:pubLevelx];
    cell.ItemList3.text     = [listTxt3 objectAtIndex:pubLevelx];
    
    //    cell.ItemFavHostBtn.tag = item.ItemList_ID;
    
    [cell.ItemImg1 setImage:[UIImage imageNamed: @"Mask + Bitmap.png"]];
    [cell.ItemImg2 setImage:[UIImage imageNamed: @"Time Copy.png"]];
    
    
    cell.ItemImg1.layer.cornerRadius    = cell.ItemImg1.frame.size.width / 2;
    cell.ItemImg1.clipsToBounds =   YES;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    MessageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
    
    [self.navigationController pushViewController:view animated:YES];
//    [self presentViewController:view animated:YES completion:nil];
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

- (void) viewWillAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:NO];
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
