//
//  SignUpViewController.m
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "SignUpViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"
//#import "AppSideSwitcherViewController.h"
#import "TabbarViewController.h"

static const CGFloat ANIMATION_DURATION3 = 0.4;
static const CGFloat LITTLE_SPACE3 = 5;
CGFloat animatedDistance3;
CGSize keyboardSize3;

@interface SignUpViewController ()


@end

@implementation SignUpViewController

@synthesize UsernameTxt, EmailTxt, FirstnameTxt, LastnameTxt, PassTxt;
@synthesize responseData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //placeholder color
    UIColor *color = [UIColor whiteColor];
    UsernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    EmailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email (Not Shared With Anyone)" attributes:@{NSForegroundColorAttributeName: color}];
    FirstnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    LastnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    PassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    [self.UsernameTxt   setReturnKeyType:UIReturnKeyNext];
    [self.EmailTxt      setReturnKeyType:UIReturnKeyNext];
    [self.FirstnameTxt  setReturnKeyType:UIReturnKeyNext];
    [self.LastnameTxt   setReturnKeyType:UIReturnKeyNext];
    [self.PassTxt       setReturnKeyType:UIReturnKeyDone];

    [self.UsernameTxt   setTag:0];
    [self.EmailTxt      setTag:1];
    [self.FirstnameTxt  setTag:2];
    [self.LastnameTxt   setTag:3];
    [self.PassTxt       setTag:4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Welcome - View2
- (IBAction)GoBack:(id)sender {
    
    [UsernameTxt resignFirstResponder];
    [PassTxt resignFirstResponder];
    [EmailTxt resignFirstResponder];
    [FirstnameTxt resignFirstResponder];
    [LastnameTxt resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Going App Side Switcher - view11
- (IBAction)GoSignUp:(id)sender {
    
    NSString *strUsername   = self.UsernameTxt.text;
    NSString *strEmail      = self.EmailTxt.text;
    NSString *strFirstname  = self.FirstnameTxt.text;
    NSString *strLastname   = self.LastnameTxt.text;
    NSString *strPass       = self.PassTxt.text;
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if ([strUsername length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STInputUsername closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    if ([strEmail length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STEmail closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    if ([strFirstname length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STFirstName closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    if ([strLastname length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STLastName closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    if ([strPass length] == 0)
    {
        [alert showNotice:self title:NoticeType subTitle:STInputPassword closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    [[ActivityIndicator currentIndicator] show];
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",SIGNIN_USERNAME_TAG,strUsername, SIGNIN_USEREMAIL_TAG, strEmail, SIGNIN_USERPWD_TAG, strPass];
    
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:SIGNUP_API];
    
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
    
    BOOL signUpResult = FALSE;
    NSString *resData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response ==> %@", resData);
    
    NSError *error = nil;
    
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingMutableContainers
                              error:&error];
    
    signUpResult = (BOOL) [jsonData[@"error"] integerValue];
    
    if(!signUpResult)
    {
        
        NSLog(@"Sigin UP SUCCESS");
        
        TabbarViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
        
        [self presentViewController:ctrl animated:YES completion:nil];
        
    } else {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:ALERT_SIGNUP_FAILED_TILE subTitle:ALERT_SIGNUP_FAILED_MSG closeButtonTitle:OkButtonTitle duration:0.0f];
        
        return;
    }
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([self.UsernameTxt isFirstResponder])[self.UsernameTxt resignFirstResponder];
    else if([self.EmailTxt isFirstResponder])[self.EmailTxt  resignFirstResponder];
    else if([self.FirstnameTxt isFirstResponder])[self.FirstnameTxt  resignFirstResponder];
    else if([self.LastnameTxt isFirstResponder])[self.LastnameTxt  resignFirstResponder];
    else if([self.PassTxt isFirstResponder])[self.PassTxt  resignFirstResponder];
    
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
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE3;//
    
    CGFloat keyboardHeight = keyboardSize3.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance3 = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION3];
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
        [UIView setAnimationDuration:ANIMATION_DURATION3];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize3 = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
}

@end
