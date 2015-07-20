//
//  PApiCall.h
//  PaxiApp
//
//  Created by TarunMahajan on 24/07/14.
//  Copyright (c) 2014 Deftsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface PApiCall : NSObject<UIAlertViewDelegate>
+(PApiCall*)sharedInstance;

-(void)m_GetApiResponse:(NSString*)methodName parameters:(NSString*)param onCompletion:(JSONResponseBlock)completionBlock;

-(void)m_GetResponseByPostMethod:(NSString*)methodName requestBody:(NSDictionary*)requestBody onCompletion:(JSONResponseBlock)completionBlock;

-(void)uploadData:(NSData *)imageData imageName:(NSString*)ImageName info:(NSDictionary*)infoDict onCompletion:(JSONResponseBlock)completionBlock;

//+(void)m_ChangePlaceholderColor:(UITextField*)textField ;

@end
