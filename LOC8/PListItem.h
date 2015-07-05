//
//  PListItem.h
//  View My Friends
//
//  Created by lion on 11/23/14.
//  Copyright (c) 2014 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListItem : NSObject {
    
    int         _place_id;
    int         _place_kind;
    int         _place_rating;
    NSString*   _place_title;
    NSString*   _place_description;
    NSString*   _place_path;
    double      _place_latitude;
    double      _place_longitude;
    NSString*   _place_username;
    
    int         _place_tid;
    
    NSString*   _name;
    NSString*   _address;
    NSString*   _icon;
    NSString*   _place;
    
    float       _latitude;
    float       _longtide;
}

@property (nonatomic)       int         place_id;
@property (nonatomic)       int         place_kind;
@property (nonatomic)       int         place_tid;
@property (nonatomic, copy) NSString*   place_title;
@property (nonatomic, copy) NSString*   place_description;
@property (nonatomic, copy) NSString*   place_path;
@property (nonatomic)       double      place_latitude;
@property (nonatomic)       double      place_longitude;
@property (nonatomic)       int         place_rating;
@property (nonatomic, copy) NSString*   place_username;

@property (nonatomic, copy) NSString*   name;
@property (nonatomic, copy) NSString*   address;
@property (nonatomic) float             latitude;
@property (nonatomic) float             longtide;
@property (nonatomic, copy) NSString*   icon;
@property (nonatomic, copy) NSString*   place;

@end
