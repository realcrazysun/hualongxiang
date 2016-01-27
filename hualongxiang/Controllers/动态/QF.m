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
    
    DetailInfoViewController* controller = [[DetailInfoViewController alloc] init];
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:controller];
    UIViewController* curVc = [Utils getPresentedViewController];
    if ([curVc isKindOfClass:[UINavigationController class]]) {
        [curVc presentViewController:navVC animated:YES completion:nil];
    }else{
        [curVc.navigationController presentViewController:navVC animated:NO completion:nil];
        
    }
}
@end
