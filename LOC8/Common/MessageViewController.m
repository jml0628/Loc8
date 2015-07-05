//
//  MessageViewController.m
//  LOC8
//
//  Created by QQQ on 6/12/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "MessageViewController.h"
#import "TabbarViewController.h"
#import "SCLAlertView.h"
#import "Config.h"
#import "ActivityIndicator.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize sendBtn, PersonMessageTxt, tmpView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [myRegScroller setScrollEnabled:YES];
    [myRegScroller setContentSize:CGSizeMake(320, 503)];
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    [self.PersonMessageTxt   setReturnKeyType:UIReturnKeyDone];
    [self.PersonMessageTxt   setTag:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    PersonMessageTxt.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going SignIn - View3
- (IBAction)GoBack:(id)sender {
    

    TabbarViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
    [ctrl setSelectedIndex:1];
    
    
//    if (_goneFlag == 0) {
//         [self dismissViewControllerAnimated:YES completion:nil];
//    } else
        [self.navigationController popViewControllerAnimated:YES];

}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([self.PersonMessageTxt isFirstResponder])[self.PersonMessageTxt resignFirstResponder];
    
    [myRegScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.returnKeyType==UIReturnKeyNext) {
        // find the text field with next tag
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone || textField.returnKeyType==UIReturnKeyDefault) {
        [textField resignFirstResponder];
        
        [myRegScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}

// Moving current text field above keyboard
-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField{
    
    
//    CGRect viewFrame = self.view.frame;
//    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
//    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
//    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
//
//    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
//    if (isTextFieldHidden) {
//        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
//        viewFrame.origin.y -= animatedDistance;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:ANIMATION_DURATION];
//        [self.view setFrame:viewFrame];
//        [UIView commitAnimations];
//    }
    
    [myRegScroller setContentOffset:CGPointMake(0, keyboardHeight) animated:YES];
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
    
    int offset = h - (myRegScroller.bounds.size.height - PersonMessageTxt.frame.origin.y - PersonMessageTxt.frame.size.height)-100;
    
//    if (offset > 0) {
//        [myRegScroller setContentOffset:CGPointMake(0, offset) animated:YES];
//    }
    [myRegScroller setContentOffset:CGPointMake(0, h) animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [PersonMessageTxt setDelegate:self];
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
