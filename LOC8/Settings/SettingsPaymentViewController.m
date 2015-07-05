//
//  SettingsPaymentViewController.m
//  LOC8
//
//  Created by QQQ on 6/13/15.
//  Copyright (c) 2015 QQQ. All rights reserved.
//

#import "SettingsPaymentViewController.h"

#import "PaymentTableViewCell.h"
#import "AddCardViewController.h"

@interface SettingsPaymentViewController ()

@end

@implementation SettingsPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DetailsData = [NSArray arrayWithObjects:@"VISA ***9203", @"TEST TEST", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Going Settings  - View22
- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [DetailsData count];
            break;
            
        case 1:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PaymentTableViewCell *cell = (PaymentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    
    if (cell == nil) {
        cell = [[PaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentCell"];
    }
    
    
    int pubLevelx = (int) indexPath.row % 2;
    
    if (indexPath.section == 0) {
        
        cell.Paymentlb.text     = [DetailsData objectAtIndex:pubLevelx];
    } else {
        
        cell.Paymentlb.text = @"+ ADD A CARD";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    ListItem2 *item = [DetailsData objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            AddCardViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCardController"];
            
            [self.navigationController pushViewController:view animated:YES];
        }
        
        
    }
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
