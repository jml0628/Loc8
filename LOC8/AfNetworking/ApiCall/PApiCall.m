//
//  PApiCall.m
//  PaxiApp
//
//  Created by TarunMahajan on 24/07/14.
//  Copyright (c) 2014 Deftsoft. All rights reserved.
//

#import "PApiCall.h"
#import "Config.h"

@implementation PApiCall

+(id)sharedInstance
{
    
    static id sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    return sharedMyModel;
//    if (!_sharedAppManager)
//        _sharedAppManager = [[PApiCall alloc] init];
//    return _sharedAppManager;
}

#pragma mark get data
-(void)m_GetApiResponse:(NSString*)methodName parameters:(NSString*)param onCompletion:(JSONResponseBlock)completionBlock
{
    NSString *string=[NSString stringWithFormat:@"%@%@",methodName,param];
    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"url is == %@",url);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
          completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
         
    }];
    
    [[NSOperationQueue currentQueue] addOperation:operation];
}


-(void)m_GetResponseByPostMethod:(NSString*)methodName requestBody:(NSDictionary*)requestBody onCompletion:(JSONResponseBlock)completionBlock
{
    NSString *string=[[NSString stringWithFormat:@"%@%@",Host_Url,methodName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSLog(@"request Body=%@",requestBody);
    [manager POST:string parameters:requestBody success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
         completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
         completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
}






#pragma mark post data
-(void)uploadData:(NSData *)imageData imageName:(NSString*)ImageName info:(NSDictionary*)infoDict onCompletion:(JSONResponseBlock)completionBlock
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation ;
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    
    //Providing the extra acceptable format for files to be uploaded
    serializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json",@"text/html", @"text/javascript",@"text/html"]];

    //Generating the request operation using the operation manager instance
    operation= [manager POST:Host_Url parameters:infoDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:ImageName fileName:@"userimg.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFormData:[[NSNumber numberWithInteger:imageData.length].stringValue dataUsingEncoding:NSUTF8StringEncoding] name:@"filelength"];
    }
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
                    {
                        NSLog(@"%@",responseObject);
                         completionBlock(responseObject);
                        }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
                    }];
    [operation setResponseSerializer:serializer];
    [operation start];
}

@end
