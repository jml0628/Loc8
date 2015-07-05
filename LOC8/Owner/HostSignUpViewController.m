//
//  HostSignUpViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "HostSignUpViewController.h"
#import "Config.h"
#import "SettingHostProViewController.h"

@interface HostSignUpViewController ()

@end

@implementation HostSignUpViewController

@synthesize bankTxt, routingTxt;
@synthesize userPic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    bankTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    routingTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    //
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewTap:)];
    tapgesture.numberOfTapsRequired = 1;
    userPic.userInteractionEnabled = YES;
    [userPic addGestureRecognizer:tapgesture];
    
    userPic.layer.cornerRadius = userPic.frame.size.width / 2;
    userPic.clipsToBounds = YES;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    [self.bankTxt setReturnKeyType:UIReturnKeyNext];
    [self.routingTxt setReturnKeyType:UIReturnKeyDone];
    
    [self.bankTxt setTag:0];
    [self.routingTxt setTag:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    DetailsData = [NSArray arrayWithObjects:@"ZIP CODE", @"LOCATION TYPE", @"AMENITIES", nil];
}

- (IBAction)GoBack:(id)sender {
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goProfile:(id)sender {
    
    SettingHostProViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingHostProController"];
    
    [self.navigationController pushViewController:view animated:YES];
}


- (void) onImageViewTap:(UITapGestureRecognizer*)gesture {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([self.bankTxt isFirstResponder])[self.bankTxt resignFirstResponder];
    if([self.routingTxt isFirstResponder])[self.routingTxt  resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
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
    
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    tableView.scrollEnabled =   NO;
    
    return [DetailsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"FilterCell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [DetailsData objectAtIndex:indexPath.row];
    
    return cell;
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
