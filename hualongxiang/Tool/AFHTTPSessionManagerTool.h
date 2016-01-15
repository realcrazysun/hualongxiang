//
//  AFHTTPSessionManagerTool.h
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHTTPSessionManagerTool : NSObject

/**
 *  发送带前缀GET请求
 *
 *  @param URLString        <#URLString description#>
 *  @param parameters       <#parameters description#>
 *  @param downloadProgress <#downloadProgress description#>
 *  @param success          <#success description#>
 *  @param failure          <#failure description#>
 */
+ (void)sendHttpGET:(NSString*)URLString
             prefix:(NSString*)prefix
         parameters:(id)parameters
           progress:(void (^)(NSProgress *))downloadProgress
            success:(void (^)(NSURLSessionDataTask *, id))success
            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

/**
 *  发送post请求
 *
 *  @param URLString  <#URLString description#>
 *  @param prefix     <#prefix description#>
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)sendHttpPost:(NSString *)URLString
             prefix:(NSString *)prefix
         parameters:(id)parameters
            success:(void (^)(NSURLSessionDataTask * , id ))success
            failure:(void (^)(NSURLSessionDataTask * , NSError *))failure;
@end
