//
//  AFHTTPSessionManagerTool.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "AFHTTPSessionManagerTool.h"
#import "AFHTTPSessionManager.h"
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
@end
