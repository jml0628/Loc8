//
//  FZipCodeViewController.m
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "FZipCodeViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"

static const CGFloat ANIMATION_DURATION4 = 0.4;
static const CGFloat LITTLE_SPACE4 = 5;
CGFloat animatedDistance4;
CGSize keyboardSize4;

@interface FZipCodeViewController ()

@end

@implementation FZipCodeViewController

@synthesize ZipCodeTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    ZipCodeTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [self.ZipCodeTxt setReturnKeyType:UIReturnKeyDone];
    
    [self.ZipCodeTxt setTag:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Browse list -  Filter - View16
- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([self.ZipCodeTxt isFirstResponder])[self.ZipCodeTxt resignFirstResponder];
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
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE4;//
    
    CGFloat keyboardHeight = keyboardSize4.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance4 = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance4;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION4];
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
        [UIView setAnimationDuration:ANIMATION_DURATION4];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize4 = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
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
