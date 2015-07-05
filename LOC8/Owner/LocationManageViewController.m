//
//  LocationManageViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "LocationManageViewController.h"
#import "Config.h"
#import "SCLAlertView.h"


#import "ADLDescViewController.h"
#import "ADLAddViewController.h"
#import "ADLHourViewController.h"
#import "ADLLocationTypeViewController.h"
#import "ADLAmenityViewController.h"
#import "ADLAttViewController.h"

@interface LocationManageViewController ()

@end

@implementation LocationManageViewController
@synthesize PriceTx, LocationNameTx, NeighTx;
@synthesize DoneBtn, DoneView;
@synthesize AddPhotosBtn, room_coll, rooms_views, main_views;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"DESCRIPTION", @"ADDRESS", @"SET AVALIBITY DAYS $ HOURS", @"LOCATION TYPE", @"AMENITIES", @"ATTENDENCE DETAILS", nil];
    
//    roomImages = [NSArray arrayWithObjects:
//                       [UIImage imageNamed:@"room001.png"],
//                       [UIImage imageNamed:@"room002.png"],
//                       [UIImage imageNamed:@"room002.png"],
//                       [UIImage imageNamed:@"room001.png"],
//                       [UIImage imageNamed:@"room002.png"],
//                       nil];
    
    roomImages = [[NSMutableArray alloc] init];
    listCount = (int) roomImages.count;
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 810)];
    
    LocationNameTx.autocorrectionType = UITextAutocorrectionTypeNo;
    NeighTx.autocorrectionType = UITextAutocorrectionTypeNo;
    PriceTx.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.LocationNameTx setReturnKeyType:UIReturnKeyNext];
    [self.NeighTx setReturnKeyType:UIReturnKeyDone];
    [self.PriceTx setReturnKeyType:UIReturnKeyDone];
    
    [self.LocationNameTx setTag:0];
    [self.NeighTx setTag:1];
    [self.PriceTx setTag:2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    // Done View hidden
    DoneView.hidden     =   YES;
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewTap:)];
    tapgesture.numberOfTapsRequired = 1;
    AddPhotosBtn.userInteractionEnabled = YES;
    [AddPhotosBtn addGestureRecognizer:tapgesture];
    
    [room_coll setDelegate:self];
    [self frameReload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Settings  - View22
- (IBAction)GoBack:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// Collapse

- (IBAction)HiddenKeyboard :(id)sender {
    
    [myRegScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [PriceTx resignFirstResponder];
    [LocationNameTx resignFirstResponder];
    [NeighTx resignFirstResponder];
    
    DoneView.hidden =   YES;
}

-(void) onImageViewTap:(UITapGestureRecognizer*)gesture {
    [self actionsheetcalled];
}

-(void)actionsheetcalled
{
    
    UIActionSheet *act=[[UIActionSheet alloc]initWithTitle:@"Select Photo From Following Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose Existing Photo", nil];
    [act showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        @try
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion: nil];
            
        }
        @catch (NSException *exception)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:@"Camera is not available  " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    else if (buttonIndex ==1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion: nil];
    }
}

#pragma mark - choose image from gallery
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //    UIColor *borderColor = [UIColor colorWithRed:255/256.0 green:255/256.0 blue:255/256.0 alpha:1.0];
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImage *img = [UIImage imageNamed:@"tbl_cellRoom1"];
    
    [roomImages addObject:img];
    
    NSLog(@"image : %@", img);
    
    [room_coll reloadData];
    
    listCount = listCount  + 1;
    
    NSLog(@"count - %d", listCount);
    
    [self frameReload];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    tableView.scrollEnabled =   NO;
    
    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"LocationMGCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel*        cellLb = (UILabel*) [cell viewWithTag:3300];
    
    
    cellLb.text= [DetailsData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        
        ADLDescViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLDescController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 1) {
        
        ADLAddViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLAddController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
        
    } else if (indexPath.row == 2) {
        
        ADLHourViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLHourController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 3) {
        
        ADLLocationTypeViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLLocationTypeController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 4) {
        
        ADLAmenityViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLAmenityController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (indexPath.row == 5) {
        
        ADLAttViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ADLAttController"];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } else {
        
        
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [myRegScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    
    DoneView.hidden =   YES;
    
    if(textField.returnKeyType==UIReturnKeyNext) {
        // find the text field with next tag
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone || textField.returnKeyType==UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

// Moving current text field above keyboard
-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField{
    
    DoneView.hidden =   NO;
    
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight - 20) ;
        viewFrame.origin.y -= animatedDistance;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:ANIMATION_DURATION];
//        [self.view setFrame:viewFrame];
//        [UIView commitAnimations];
    }

    
//    UITextPosition *beginning = [textField beginningOfDocument];
//    [textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
    
    textfeildOriginY    = textFieldRect.origin.y;
    
    return YES;
}

-(void) restoreViewFrameOrigionYToZero{
    
    CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y != 0) {
        viewFrame.origin.y = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    if(!self.isViewLoaded || !self.view.window) {
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardFrameInWindow;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrameInWindow];
    
    int keyboardHeight = keyboardFrameInWindow.size.height;
    
    DoneView.hidden =   NO;
    
    UIView *moveView    = [self.view viewWithTag:5];
    CGRect frame        = moveView.frame;
    
    [moveView removeFromSuperview];
    
    frame.origin.y = self.view.bounds.size.height - keyboardHeight - 30;
    moveView.frame  =   frame;
    
    [self.view addSubview:moveView];
    
    int offset = textfeildOriginY - keyboardHeight;

    if (offset > 0) {
        [myRegScroller setContentOffset:CGPointMake(0, offset) animated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [PriceTx setDelegate:self];
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell2" forIndexPath:indexPath];
    
    UIImageView * imageRoomView =(UIImageView *)[cell viewWithTag:3311];
    UIImageView * imagecloseBtn =(UIImageView *)[cell viewWithTag:3312];
    
    imageRoomView.image = [roomImages objectAtIndex:indexPath.row];
    [imagecloseBtn setImage:[UIImage imageNamed: @"btn_close2.png"]];
    
    imageRoomView.contentMode = UIViewContentModeScaleAspectFill;
    imageRoomView.clipsToBounds = YES;
    
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RemoveRoomBtn:)];
    
    [imagecloseBtn setUserInteractionEnabled:YES];
    [imagecloseBtn addGestureRecognizer:photoTap];
    
    return cell;
}

- (void)RemoveRoomBtn:(UIButton*)sender {
    
    listCount = listCount - 1;
    
    [self frameReload];

    return;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return listCount;
//    return roomImages.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)frameReload {
    
    int photoCount = (int) [roomImages count];
    
//    if (photoCount == 0) {

    if (listCount == 0) {
        rooms_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 0);
        main_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 710);
    } else {
        
        rooms_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 110);
        main_views.frame = CGRectMake(0, 110, myRegScroller.frame.size.width, 710);
        
    }
    [self.room_coll reloadData];
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
