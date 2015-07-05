//
//  HeightViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "HeightViewController.h"
#import "Config.h"

@interface HeightViewController ()

@end

@implementation HeightViewController

@synthesize FeetTx, InchesTx, SaveBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    FeetTx.keyboardType     = UIKeyboardTypeNumberPad;
    InchesTx.keyboardType   = UIKeyboardTypeNumberPad;
    
    
    [self.FeetTx setReturnKeyType:UIReturnKeyNext];
    [self.InchesTx setReturnKeyType:UIReturnKeyDone];
    
    [self.FeetTx setTag:0];
    [self.InchesTx setTag:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (userFlag == 2) {
        SaveBtn.hidden = YES;
    } else {
        SaveBtn.hidden = NO;
    }
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    if([self.FeetTx isFirstResponder])[self.FeetTx resignFirstResponder];
    if([self.InchesTx isFirstResponder])[self.InchesTx  resignFirstResponder];
    
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
    
    if (userFlag == 2) {
        
        return  NO;
    } else {
        
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
        
        return  YES;
    }
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
