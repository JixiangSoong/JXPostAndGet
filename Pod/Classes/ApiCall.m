//
//  ApiCall.m
//  
//
//  Created by 宋吉祥 on 15/3/30.
//  Copyright (c) 2015年 soong. All rights reserved.
//

#import "ApiCall.h"

@implementation ApiCall

static ApiCall *defaultApiCall = nil;
//单例
+ (instancetype)defaultApiCal {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        defaultApiCall = [[ApiCall alloc] init];
    });
    return defaultApiCall;
}

//POST
- (NSString *)postResponse:(NSString *)payload withURL:(NSString *)urlString {
    //设置request参数
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //转化为JSON字符串
    NSData *requestData = [payload dataUsingEncoding: NSUTF8StringEncoding];
    NSString *postString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"API_CALL_POST_URL: %@", urlString);
    NSLog(@"API_CALL_POST: %@", postString);
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    
    //发送请求，获取结果
    NSHTTPURLResponse *response;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *result = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"API_CALL_RESULT:%@", result);
    return result;
}

//GET
- (NSString *)getResponse:(NSString *)urlString {
    //初始化
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    //设置请求
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求，获取结果
    NSError *error;
    NSURLResponse *response;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *result = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"API_CALL_GET_URL:%@", urlString);
//    NSLog(@"API_CALL_RESULT:%@", result);
    return result;
}

//从JSON数据中解析出字典
+ (NSMutableDictionary *) getDictFromJson:(NSString *)input {
    NSData *jsonData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parseData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return parseData;
}

@end
