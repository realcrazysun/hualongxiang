//
//  AFHTTPSessionManagerTool.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "AFHTTPSessionManagerTool.h"
#import "AFHTTPSessionManager.h"
#import "Config.h"
#import "User.h"
@implementation AFHTTPSessionManagerTool
+(void)sendHttpGET:(NSString *)URLString prefix:(NSString *)prefix parameters:(id)parameters progress:(void (^)(NSProgress * ))downloadProgress success:(void (^)(NSURLSessionDataTask * , id ))success failure:(void (^)(NSURLSessionDataTask * , NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString* url = [NSString stringWithFormat:@"%@%@",prefix,URLString];
    [manager GET:url parameters:nil progress:nil success:success failure:failure
    ];

}

+(void)sendHttpPost:(NSString *)URLString
             prefix:(NSString *)prefix
         parameters:(id)parameters
            success:(void (^)(NSURLSessionDataTask * , id ))success
            failure:(void (^)(NSURLSessionDataTask * , NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString* url = [NSString stringWithFormat:@"%@%@",prefix,URLString];
    [manager POST:url
       parameters:parameters
         progress:nil
          success:success
          failure:failure];
}

+(NSMutableDictionary*)defaultParameters{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"8a7c2136f86a95e256b67e73de4c1544" forKey:@"access_token"];
    [parameters setObject:@"E542B165-08ED-4529-AF7C-B15F8DE0B199" forKey:@"device"];
    
//    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
//    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"qq" forKey:@"weiboType"];
//    [params setObject:@"3D30D2BF01AD011252695BCE71B89AFC" forKey:@"openId"];
//    [data setObject:params forKey:@"params"];
//    [parameters setObject:[data mj_JSONString] forKey:@"data"];
    
    User* user = [Config myProfile];
    if (user) {
        [parameters setObject:user.login_token forKey:@"login_token"];
        [parameters setObject:[NSNumber numberWithInt:user.uid ] forKey:@"user_id"];
    }
    [parameters setObject:@"iPhone 5" forKey:@"platform"];
    [parameters setObject:@"1" forKey:@"network"];
    [parameters setObject:@"568.000000" forKey:@"screen_height"];
    [parameters setObject:@"320.000000" forKey:@"screen_width"];
    [parameters setObject:@"1" forKey:@"system"];
    [parameters setObject:@"9.2" forKey:@"system_version"];
    [parameters setObject:@"4.4.0" forKey:@"version"];
    return parameters;
}

@end
