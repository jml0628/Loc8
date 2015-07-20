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
#import "ActivityIndicator.h"
#import "ADLDescViewController.h"
#import "ADLAddViewController.h"
#import "ADLHourViewController.h"
#import "ADLLocationTypeViewController.h"
#import "ADLAmenityViewController.h"
#import "ADLAttViewController.h"

#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "PApiCall.h"

@interface LocationManageViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation LocationManageViewController
@synthesize PriceTx, LocationNameTx, NeighTx;
@synthesize DoneBtn, DoneView;
@synthesize AddPhotosBtn, room_coll, rooms_views, main_views;

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    appDelegate = [AppDelegate sharedDelegate];
    alert = [[SCLAlertView alloc] init];
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
    if ([appDelegate.updateString isEqualToString:@"update"]) {
        [self getData];
    }else{
        [appDelegate.locationDict removeAllObjects];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getData
{
    NSString *userId= appDelegate.userKey;
    [[ActivityIndicator currentIndicator] show];
    
    [[PApiCall sharedInstance]m_GetApiResponse:Host_Url parameters:[NSString stringWithFormat:@"mode=GetLocation&user_id=%@&location_id=%@",userId,appDelegate.updateId] onCompletion:^(NSDictionary *json) {
        NSLog(@"edit data : %@",json);
        [[ActivityIndicator currentIndicator] hide];

        [dataArray removeAllObjects];

        if([[json valueForKey:@"value"] isKindOfClass:[NSArray class]])
        {
            [ dataArray addObjectsFromArray:[json valueForKey:@"value"]];
        }
    
        NSString *descString = [[dataArray valueForKey:@"location_description"]objectAtIndex:0];
        
        NSString *addressString = [[dataArray valueForKey:@"address"]objectAtIndex:0];
        NSString *apartString = [[dataArray valueForKey:@"ATP"]objectAtIndex:0];
        NSString *cityString = [[dataArray valueForKey:@"city"]objectAtIndex:0];
        NSString *stateString = [[dataArray valueForKey:@"state"]objectAtIndex:0];
        NSString *zipCodeString = [[dataArray valueForKey:@"zip"]objectAtIndex:0];
        
        NSString *amentiesString = [[dataArray valueForKey:@"location_amenty"]objectAtIndex:0];
        NSString *attendanceString = [[dataArray valueForKey:@"location_ateendency"]objectAtIndex:0];
        NSString *location_typeString = [[dataArray valueForKey:@"location_type"]objectAtIndex:0];
        
        NSString *fullDate = [[dataArray valueForKey:@"date"]objectAtIndex:0];
        
        NSString *startTimeString = [[dataArray valueForKey:@"start_time"]objectAtIndex:0];
        NSString *endTimeString = [[dataArray valueForKey:@"end_time"]objectAtIndex:0];
        NSString *startDateString = [[dataArray valueForKey:@"start_date"]objectAtIndex:0];
        NSString *endDateString = [[dataArray valueForKey:@"end_date"]objectAtIndex:0];
        NSString *availableDays = [[dataArray valueForKey:@"available_days"]objectAtIndex:0];
        
        NSString *LocationNameString = [[dataArray valueForKey:@"location_name"]objectAtIndex:0];
        NSString *neightBhordString = [[dataArray valueForKey:@"location_neighborhood"]objectAtIndex:0];
        NSString *priceLocationString = [[dataArray valueForKey:@"price_hour"]objectAtIndex:0];
        
        
        NSString *imageURL = [[dataArray valueForKey:@"image_data"]objectAtIndex:0];
        
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        if (roomImages.count){
            [roomImages removeAllObjects];
        }
        
        [roomImages addObject:img];
        locationImage = img;
        [self frameReload];
        
        LocationNameTx.text = [NSString stringWithFormat:@"%@",LocationNameString];
        NeighTx.text = [NSString stringWithFormat:@"%@",neightBhordString];
        PriceTx.text = [NSString stringWithFormat:@"%@",priceLocationString];
        [appDelegate.locationDict setObject:descString forKey:@"location_description"];
        [appDelegate.locationDict setObject:addressString forKey:@"address"];
        [appDelegate.locationDict setObject:apartString forKey:@"ATP"];
        [appDelegate.locationDict setObject:cityString forKey:@"city"];
        [appDelegate.locationDict setObject:stateString forKey:@"state"];
        [appDelegate.locationDict setObject:zipCodeString forKey:@"zip"];
        [appDelegate.locationDict setObject:amentiesString forKey:@"location_amenty"];
        [appDelegate.locationDict setObject:attendanceString forKey:@"location_ateendency"];
        [appDelegate.locationDict setObject:location_typeString forKey:@"location_type"];
        [appDelegate.locationDict setObject:fullDate forKey:@"date"];
        [appDelegate.locationDict setObject:startTimeString forKey:@"start_time"];
        [appDelegate.locationDict setObject:endTimeString forKey:@"end_time"];
        [appDelegate.locationDict setObject:startDateString forKey:@"start_date"];
        [appDelegate.locationDict setObject:endDateString forKey:@"end_date"];
        [appDelegate.locationDict setObject:availableDays forKey:@"available_days"];
        
        
    }];
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
    locationImage = img;
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
    [super viewWillAppear:YES];
    NSLog(@"%@hjf",appDelegate.locationDict);
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
    
    [self frameReload];

    return;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return roomImages.count;
//    return roomImages.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)frameReload {
    
    if (roomImages.count == 0) {
        rooms_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 0);
        main_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 710);
    } else {
        rooms_views.frame = CGRectMake(0, 0, myRegScroller.frame.size.width, 110);
        main_views.frame = CGRectMake(0, 110, myRegScroller.frame.size.width, 710);
        
    }
    [self.room_coll reloadData];
}



#pragma mark button Action
- (IBAction)addLocationAction:(id)sender
{
      NSData* pictureData = UIImageJPEGRepresentation(locationImage, 0.3);
    if(pictureData==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Add Photo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSLog(@"dict is %@",appDelegate.locationDict);
    
    NSString *locationString = [NSString stringWithFormat:@"%@",LocationNameTx.text];
    NSString *neighString = [NSString stringWithFormat:@"%@",NeighTx.text];
    
    NSString *descString = [appDelegate.locationDict valueForKey:@"location_description"];
    
    NSString *priceString = [NSString stringWithFormat:@"%@",PriceTx.text];
    
    NSString *addressString =   [appDelegate.locationDict valueForKey:@"address"];
    NSString *apartString =     [appDelegate.locationDict valueForKey:@"ATP"];
    NSString *cityString =      [appDelegate.locationDict valueForKey:@"city"];
    NSString *stateString =     [appDelegate.locationDict valueForKey:@"state"];
    NSString *zipCodeString =   [appDelegate.locationDict valueForKey:@"zip"];
    
    NSString *amentiesString = [appDelegate.locationDict valueForKey:@"location_amenty"];
    NSString *attendanceString = [appDelegate.locationDict valueForKey:@"location_ateendency"];
    NSString *location_typeString = [appDelegate.locationDict valueForKey:@"location_type"];
    
    NSString *fullDate = [appDelegate.locationDict valueForKey:@"date"];
    NSString *userID =appDelegate.userKey;
    
    NSString *startTimeString = [appDelegate.locationDict valueForKey:@"start_time"];
    NSString *endTimeString = [appDelegate.locationDict valueForKey:@"end_time"];
    NSString *startDateString = [appDelegate.locationDict valueForKey:@"start_date"];
    NSString *endDateString = [appDelegate.locationDict valueForKey:@"end_date"];
    NSString *availableDays = [appDelegate.locationDict valueForKey:@"available_days"];
    if (locationString == nil || [locationString isKindOfClass:[NSNull class]]) {
         [alert showNotice:self title:nil subTitle:@"Plese enter location name" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    if (neighString == nil || [neighString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:nil subTitle:@"Please enter neighborhood" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (priceString == nil || [priceString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:nil subTitle:@"Please enter price" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (descString == nil || [descString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:nil subTitle:@"Please enter description" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (addressString == nil || [addressString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"Address" subTitle:@"Please enter address" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    if (apartString == nil || [apartString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"Address" subTitle:@"Please enter APT#" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    if (cityString == nil || [cityString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"Address" subTitle:@"Please enter city" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    if (stateString == nil || [stateString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"Address" subTitle:@"Please enter state" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    if (zipCodeString == nil || [zipCodeString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"Address" subTitle:@"Please enter zip code" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (availableDays == nil || [fullDate isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"SET AVALIBITY DAYS $ HOURS" subTitle:@"Please Select Avaibity Days" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (amentiesString == nil || [amentiesString isKindOfClass:[NSNull class]]) {
        
        [alert showNotice:self title:nil subTitle:@"Plese Select Amenties" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (location_typeString == nil || [location_typeString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:nil subTitle:@"Plese select Location Type" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (attendanceString == nil || [attendanceString isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:nil subTitle:@"Plese Select Attendance" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if (fullDate == nil || [fullDate isKindOfClass:[NSNull class]]) {
        [alert showNotice:self title:@"SET AVALIBITY DAYS $ HOURS" subTitle:@"Please Select Avaibity Date & Time" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    
    
    [[ActivityIndicator currentIndicator] show];
    NSDictionary * dict;
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:appDelegate.AddressDictionary options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString;
//    if (! jsonData)
//    {
//        NSLog(@"Got an error: %@", error);
//    }
//    else
//    {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//----------------------------------------------dictonary----------------------------------
if([appDelegate.updateString isEqualToString:@"update"])
    {
        dict = @{@"mode":@"EditLocation",@"user_id":userID,@"location_name":locationString,@"location_neighborhood":neighString,@"price_hour":priceString,@"location_description":descString,@"address":addressString,@"ATP":apartString,@"city":cityString,@"state":stateString,@"zip":zipCodeString,@"available_days":availableDays,@"location_type":location_typeString,@"location_amenty":amentiesString,@"location_ateendency":attendanceString,@"date":fullDate,@"location_id":appDelegate.updateId,@"start_date":startDateString,@"end_date":endDateString,@"start_time":startTimeString,@"end_time":endTimeString};
    }else{
   dict = @{@"mode":@"AddLocation",@"user_id":userID,@"location_name":locationString,@"location_neighborhood":neighString,@"price_hour":priceString,@"location_description":descString,@"address":addressString,@"ATP":apartString,@"city":cityString,@"state":stateString,@"zip":zipCodeString,@"available_days":availableDays,@"location_type":location_typeString,@"location_amenty":amentiesString,@"location_ateendency":attendanceString,@"date":fullDate,@"start_date":startDateString,@"end_date":endDateString,@"start_time":startTimeString,@"end_time":endTimeString};
    }
//--------------------------------------------------------------------------------------------
    [[PApiCall sharedInstance] uploadData:pictureData imageName:@"filename1" info:dict onCompletion:^(NSDictionary *json) {
        [[ActivityIndicator currentIndicator] hide];
        NSLog(@"%@",json);
        [self performSelector:@selector(dissMissView) withObject:self afterDelay:2.0];
    }];
   
//   [[ISAPIManager sharedInstance]multistagePOST:nil parameters:dict attachImage:locationImage success:^(id responseObject, NSError *error){
//        [[ActivityIndicator currentIndicator] hide];
//       [self performSelector:@selector(dissMissView) withObject:self afterDelay:2.0];
//       NSLog(@"dsdh %@",responseObject);
//    }failure:^(id responseObject, NSError *error)
//     {
//         [[ActivityIndicator currentIndicator] hide];
//         
//         NSLog(@"%@",responseObject);
//         NSLog(@"%@",error);
//     }];
}
- (void)dissMissView
{
    
 [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
