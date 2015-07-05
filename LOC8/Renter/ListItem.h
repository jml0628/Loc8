//
//  ListItem.h
//  Emergency Alert App
//
//  Created by symon konstenko on 1/6/15.
//  Copyright (c) 2015 Lee M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject {
    
    NSString*   _ItemListTxt1;
    NSString*   _ItemListTxt2;
    NSString*   _ItemListTxt3;
    NSString*   _ItemListTxt4;
    
    NSString*   _ItemListImg1;
    NSString*   _ItemListImg2;
    
    int         _ItemList_ID;
}

@property (nonatomic, copy) NSString*   ItemListTxt1;
@property (nonatomic, copy) NSString*   ItemListTxt2;
@property (nonatomic, copy) NSString*   ItemListTxt3;
@property (nonatomic, copy) NSString*   ItemListTxt4;

@property (nonatomic, copy) NSString*   ItemListImg1;
@property (nonatomic, copy) NSString*   ItemListImg2;

@property (nonatomic)       int         ItemList_ID;

@end
