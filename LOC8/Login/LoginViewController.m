//
//  LoginViewController.m
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "LoginViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"
//#import "AppSideSwitcherViewController.h"
#import "TabbarViewController.h"



@interface LoginViewController ()

@end


@implementation LoginViewController

@synthesize UsernameTxt, PasswordTxt;
@synthesize responseData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    [self.UsernameTxt setReturnKeyType:UIReturnKeyNext];
    [self.PasswordTxt setReturnKeyType:UIReturnKeyDone];
    
    [self.UsernameTxt setTag:0];
    [self.PasswordTxt setTag:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //placeholder color
    UIColor *color = [UIColor whiteColor];
    UsernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    PasswordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    UsernameTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Going Welcome - View2
- (IBAction)GoBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// Going App Side Switcher - view11
- (IBAction)GoSignIn:(id)sender {
    
    NSString *strUsername = self.UsernameTxt.text;
    NSString *strPassword = self.PasswordTxt.text;
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if ([strUsername length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STInputUsername closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    if ([strPassword length] == 0)
    {
        [alert showNotice:self title:NoticeType subTitle:STInputPassword closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    [[ActivityIndicator currentIndicator] show];
    NSString *post = [NSString stringWithFormat:@"%@=%@&%@=%@",SIGNIN_USERNAME_TAG, strUsername, SIGNIN_USERPWD_TAG, strPassword];
    
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:SIGNIN_API];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"APPLICATION/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"APPLICATION/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    responseData = [[NSMutableData alloc] init];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];

    [alert showError:self title:Alert subTitle:ERFailInternet closeButtonTitle:OkButtonTitle duration:0.0f];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [[ActivityIndicator currentIndicator] hide];
    
    BOOL logInResult = 0;
    NSString *resData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response ==> %@", resData);
    
    NSError *error = nil;
    
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingMutableContainers
                              error:&error];
    
    logInResult = (BOOL) [jsonData[@"error"] integerValue];
    
    if(!logInResult)
    {
        
        NSLog(@"Login SUCCESS");
        
        TabbarViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
        
        [self presentViewController:ctrl animated:YES completion:nil];
        
    } else {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:ALERT_LOGIN_FAILED_TITLE subTitle:ALERT_LOGIN_FAILED_MSG closeButtonTitle:OkButtonTitle duration:0.0f];
        
        return;
    }
}


// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    if([self.UsernameTxt isFirstResponder])[self.UsernameTxt resignFirstResponder];
    if([self.PasswordTxt isFirstResponder])[self.PasswordTxt  resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UIView *moveView = [self.view viewWithTag:5];
    [moveView removeFromSuperview];
    
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
    
    UITextPosition *beginning = [textField beginningOfDocument];
    [textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
//    
//    UIView *moveView = [self.view viewWithTag:5];
//    CGRect frame = moveView.frame;
//    
//    [moveView removeFromSuperview];
//    
//    frame.origin.y = frame.origin.y - keyboardHeight;
//    moveView.frame = frame;
//    
//    [self.view addSubview:moveView];
    
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
    
    int h = keyboardFrameInWindow.size.height;
    
    
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:PasswordTxt.bounds fromView:PasswordTxt];
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
    
    UITextPosition *beginning = [PasswordTxt beginningOfDocument];
    [PasswordTxt setSelectedTextRange:[PasswordTxt textRangeFromPosition:beginning toPosition:beginning]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [PasswordTxt setDelegate:self];
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
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
