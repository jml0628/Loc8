//
//  SettingsMainViewController.m
//  LOC8
//
//  Created by QQQ on 6/11/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "SettingsMainViewController.h"
#import "ViewController.h"
#import "Config.h"

#import "SettingHostProViewController.h"
#import "SettingsPaymentViewController.h"
#import "FavriteHostViewController.h"

@interface SettingsMainViewController ()

@end

@implementation SettingsMainViewController

@synthesize firstName, lasttName, emailName;


@synthesize userPic;
@synthesize tbl_detail, tbl_hostInfo, tbl_otherSet;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 1153)];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
//    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewTap:)];
    tapgesture.numberOfTapsRequired = 1;
    userPic.userInteractionEnabled = YES;
    [userPic addGestureRecognizer:tapgesture];
    
    userPic.layer.cornerRadius = userPic.frame.size.width / 2;
    userPic.clipsToBounds = YES;
    
    DetailsData = [NSArray arrayWithObjects:@"PAYMENT", @"FAVORITE HOSTS", nil];
    HostInfoData = [NSArray arrayWithObjects:@"HOST", @"BANK INFORMATION (FOR HOSTS)", nil];
    OtherSetData = [NSArray arrayWithObjects:@"TERMS OF SERVICE", @"PRIVACY POLICY", @"CONTACT US", @"FAQ", @"ABOUT", nil];
    
//    // add tap gesture to help in dismissing keyboard
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
//                                           initWithTarget:self
//                                           action:@selector(tapScreen:)];// outside textfields
//    
//    [self.view addGestureRecognizer:tapGesture];
//    
//    
//    [self.firstName     setReturnKeyType:UIReturnKeyNext];
//    [self.lasttName     setReturnKeyType:UIReturnKeyNext];
//    [self.emailName     setReturnKeyType:UIReturnKeyDone];
//
//    
//    [self.firstName     setTag:0];
//    [self.lasttName     setTag:1];
//    [self.emailName     setTag:2];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going SignIn - View3
- (IBAction)GoBack:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)GoFistPage:(id)sender {
    
    PersonLoginFlag = 0;
    
    ViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self presentViewController:view animated:YES completion:nil];
}

-(void) onImageViewTap:(UITapGestureRecognizer*)gesture {
    [self actionsheetcalled];
}

-(void)actionsheetcalled
{
    
    UIActionSheet *act=[[UIActionSheet alloc]initWithTitle:@"Select Photo From Following Option" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose Existing Photo", nil];
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
    
    userPic.layer.cornerRadius = userPic.frame.size.width / 2;
//    userPic.layer.borderWidth = 1;
//    [userPic.layer setBorderColor:borderColor.CGColor];
    userPic.clipsToBounds = YES;
    userPic.image=img;
    
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    userPic.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tbl_detail) {
        
        return [DetailsData count];
    } else if (tableView == tbl_hostInfo){
        
        return [HostInfoData count];
    } else if (tableView == tbl_otherSet) {
        
        return [OtherSetData count];
    } else {
        
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (tableView.tag == 1) {
        
        NSString *simpleTableIdentifier = @"settingDetailCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        UILabel*        cellLb = (UILabel*) [cell viewWithTag:2201];
        
        
        cellLb.text = [DetailsData objectAtIndex:indexPath.row];
        
        return cell;
        
    }  if (tableView.tag == 2) {
        
        NSString *simpleTableIdentifier = @"settingHostCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        UILabel*        cellLb = (UILabel*) [cell viewWithTag:2202];
        
        
        cellLb.text = [HostInfoData objectAtIndex:indexPath.row];
        
        return cell;
        
    }  if (tableView.tag == 3) {
        
        NSString *simpleTableIdentifier = @"settingOtherCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        UILabel*        cellLb = (UILabel*) [cell viewWithTag:2203];
        
        
        cellLb.text = [OtherSetData objectAtIndex:indexPath.row];
        
        return cell;
        
    } else {
        
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (tableView.tag == 1) {
        
        if (indexPath.row == 0) {
            
            SettingsPaymentViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsPaymentController"];
            
            [self.navigationController pushViewController:view animated:YES];
            
        } else if (indexPath.row == 1) {
            
            FavriteHostViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FavriteHostController"];
            
            [self.navigationController pushViewController:view animated:YES];
        } else {
            
        }
        
    } else if (tableView.tag == 2) {
        
        if (indexPath.row == 0) {
            
            SettingHostProViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingHostProController"];
            
            [self.navigationController pushViewController:view animated:YES];
        }
        
    } else if (tableView.tag == 2) {
        
    } else {
        
    }

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


//// dismiss keyboard when tap outside text fields
//- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
//    
//    if([self.firstName isFirstResponder])[self.firstName resignFirstResponder];
//    else if([self.lasttName isFirstResponder])[self.lasttName  resignFirstResponder];
//    else if([self.emailName isFirstResponder])[self.emailName  resignFirstResponder];
//    
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
