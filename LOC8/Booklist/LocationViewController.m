//
//  LocationViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "LocationViewController.h"
#import "UIImage+ImageEffects.h"

#import "MessageViewController.h"
#import "BookRoomDatesViewController.h"
#import "PropertyOwnProfileViewController.h"

@interface LocationViewController ()

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation LocationViewController
@synthesize scrollRoomView, pageroomControl;
@synthesize pageImages, pageViews;
@synthesize OwnerSmallPic, OwnerWidePic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 1039)];
    
    
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"room001.png"],
                       [UIImage imageNamed:@"room002.png"],
                       [UIImage imageNamed:@"room002.png"],
                       [UIImage imageNamed:@"room001.png"],
                       [UIImage imageNamed:@"room002.png"],
                       nil];
    
    NSInteger pageCount = self.pageImages.count;
    
    // Set up the page control
    self.pageroomControl.currentPage    = 0;
    self.pageroomControl.numberOfPages  = pageCount;
    
    // Set up the array to hold the views for each page
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
    OwnerSmallPic.layer.cornerRadius = 5;
    OwnerSmallPic.clipsToBounds = YES;
    
    // Croping
//    UIImage *img = [self centerCropImage:OwnerSmallPic.image];
    OwnerWidePic.image = [UIImage imageWithBlurImage:OwnerSmallPic.image];
    OwnerWidePic.contentMode = UIViewContentModeScaleAspectFill;
    OwnerWidePic.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = scrollRoomView.frame.size;
    scrollRoomView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoBack:(id)sender {
    
//    //    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoMessageView:(id)sender {
    
    MessageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageController"];
    
    view.goneFlag = 1;
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)GoBookRoomDates:(id)sender {
    
    BookRoomDatesViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"BookRoomDatesController"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)GoPropertyOwnerProfile:(id)sender {
    PropertyOwnProfileViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyOwnProfileController"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollRoomView.frame.size.width;
    
    NSInteger page = (NSInteger)floor((self.scrollRoomView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageroomControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollRoomView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        
//        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.contentMode = UIViewContentModeScaleAspectFill;
        newPageView.frame = frame;
        [self.scrollRoomView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollRoomView = nil;
    self.pageroomControl = nil;
    self.pageImages = nil;
    self.pageViews = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
    ////
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

// Returns largest possible centered cropped image.
- (UIImage *)centerCropImage:(UIImage *)image
{
    // Use smallest side length as crop square length
//    CGFloat squareLength = MIN(image.size.width, image.size.height);
    
    float compare = self.view.frame.size.width / 375;
    // Center the crop area
    
    CGRect clippedRect = CGRectMake(0, 15, image.size.width, 73 * compare);
    
    // Crop logic
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    UIImage * croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
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
