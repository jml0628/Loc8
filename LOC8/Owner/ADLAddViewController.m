//
//  ADLAddViewController.m
//  LOC8
//
//  Created by QQQ on 6/15/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "ADLAddViewController.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ADLAddViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ADLAddViewController
@synthesize Address1Txt, Address2Txt, Address3Txt, Address4Txt, Address5Txt;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [AppDelegate sharedDelegate];
    // Do any additional setup after loading the view.
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    NSString *address = [appDelegate.locationDict valueForKey:@"address"];
    NSString *apartment = [appDelegate.locationDict valueForKey:@"ATP"];
    NSString *city = [appDelegate.locationDict valueForKey:@"city"];
    NSString *state = [appDelegate.locationDict valueForKey:@"state"];
    NSString *zipCode = [appDelegate.locationDict valueForKey:@"zip"];
    if (address == nil || [address isKindOfClass:[NSNull class]]) {
        
    }else{
        self.Address1Txt.text = [NSString stringWithFormat:@"%@",address];
    }
    if (apartment == nil || [apartment isKindOfClass:[NSNull class]]) {
        
    }else{
        self.Address2Txt.text = [NSString stringWithFormat:@"%@",apartment];
    }
    
    if (city == nil || [city isKindOfClass:[NSNull class]]) {
        
    }else{
        self.Address3Txt.text = [NSString stringWithFormat:@"%@",city];
    }
    if (state == nil || [state isKindOfClass:[NSNull class]]) {
        
    }else{
        self.Address4Txt.text = [NSString stringWithFormat:@"%@",state];
    }
    if (zipCode == nil || [zipCode isKindOfClass:[NSNull class]]) {
        
    }else{
        self.Address5Txt.text = [NSString stringWithFormat:@"%@",zipCode];
    }
    
    [self.Address1Txt setReturnKeyType:UIReturnKeyNext];
    [self.Address2Txt setReturnKeyType:UIReturnKeyNext];
    [self.Address3Txt setReturnKeyType:UIReturnKeyNext];
    [self.Address4Txt setReturnKeyType:UIReturnKeyNext];
    [self.Address5Txt setReturnKeyType:UIReturnKeyDone];
    
    [self.Address1Txt setTag:0];
    [self.Address2Txt setTag:1];
    [self.Address3Txt setTag:2];
    [self.Address4Txt setTag:3];
    [self.Address5Txt setTag:4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    if ([appDelegate.updateString isEqualToString:@"update"]) {
        Address1Txt.text = [appDelegate.locationDict valueForKey:@"address"];
        Address2Txt.text = [appDelegate.locationDict valueForKey:@"ATP"];
        Address3Txt.text = [appDelegate.locationDict valueForKey:@"city"];
        Address4Txt.text = [appDelegate.locationDict valueForKey:@"state"];
        Address5Txt.text = [appDelegate.locationDict valueForKey:@"zip"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoSave:(id)sender {
    [appDelegate.locationDict setObject:Address1Txt.text forKey:@"address"];
    [appDelegate.locationDict setObject:Address2Txt.text forKey:@"ATP"];
    [appDelegate.locationDict setObject:Address3Txt.text forKey:@"city"];
    [appDelegate.locationDict setObject:Address4Txt.text forKey:@"state"];
    [appDelegate.locationDict setObject:Address5Txt.text forKey:@"zip"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    if([self.Address1Txt isFirstResponder])
        [self.Address1Txt resignFirstResponder];
    
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
