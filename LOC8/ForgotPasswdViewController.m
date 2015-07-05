//
//  ForgotPasswdViewController.m
//  LOC8
//
//  Created by QQQ on 6/10/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ForgotPasswdViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"

@interface ForgotPasswdViewController ()

@end

@implementation ForgotPasswdViewController

@synthesize FPUsername;
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FPUsername.delegate = self;
    
    //placeholder color
    UIColor *color = [UIColor whiteColor];
    FPUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    [self.FPUsername setReturnKeyType:UIReturnKeyDone];
    
    [self.FPUsername setTag:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    FPUsername.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going SignIn - View3
- (IBAction)GoBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Going SignIn - view3
- (IBAction)GoSignIn:(id)sender {
    
    NSString *strUsername = self.FPUsername.text;
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if ([strUsername length] == 0)
    {
        
        [alert showNotice:self title:NoticeType subTitle:STInputUsername closeButtonTitle:CloseButtonTitle duration:0.0f];
        
        return;
    }
    
    [[ActivityIndicator currentIndicator] show];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_email=%@",strUsername];
    
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
    
    [[ActivityIndicator currentIndicator] hide];
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showError:self title:Alert subTitle:ERFailInternet closeButtonTitle:OkButtonTitle duration:0.0f];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [[ActivityIndicator currentIndicator] hide];
    
    int success = 0;
    NSString *resData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response ==> %@", resData);
    
    NSError *error = nil;
    
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingMutableContainers
                              error:&error];
    
    success = (int) [jsonData[@"success"] integerValue];
    
    if(success == 1)
    {
        
        NSLog(@"Login SUCCESS");
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:NoticeType subTitle:STEmpty closeButtonTitle:OkButtonTitle duration:0.0f];
        
        return;
    }
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    if([self.FPUsername isFirstResponder])[self.FPUsername resignFirstResponder];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
