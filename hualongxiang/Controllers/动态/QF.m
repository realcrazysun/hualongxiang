//
//  QF.m
//  hualongxiang
//
//  Created by polyent on 16/1/22.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "QF.h"
#import "DetailInfoViewController.h"
#import "Utils.h"
@interface QF()

@end

@implementation QF
-(void)callNative:(NSDictionary*)dic{
    NSLog(@"%@",dic);
    NSString* method = [dic objectForKey:@"method"];
    NSDictionary* params = [dic objectForKey:@"params"];
#warning 这里要dispatch至主线程执行UI操作
    dispatch_async(dispatch_get_main_queue(), ^{
        DetailInfoViewController* controller = [[DetailInfoViewController alloc] init:NO
                                                                              loadUrl:@"http://hualongxiang.qianfanapi.com/v1_4/wap/view-thread?tid=12449377&isSeeMaster=0&replyOrder=0&viewpid=0"
                                                                                liked:(BOOL)YES
                                                                            replyNums:(NSUInteger)11];
        
        
        
        [self.fromVC.navigationController pushViewController:controller animated:YES];
    });
    
}
@end
