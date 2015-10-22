//
//  ApiCall.h
//  
//
//  Created by 宋吉祥 on 15/3/30.
//  Copyright (c) 2015年 soong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiCall : NSObject

+ (instancetype) defaultApiCal;
+ (NSMutableDictionary *) getDictFromJson:(NSString *)input;

- (NSString *) postResponse:(NSString *)payload withURL:(NSString *)urlString;
- (NSString *) getResponse:(NSString *)urlString;

@end
