//
//  LoginViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/26.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Wonderful.h"
#import "MJExtension.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "User.h"
#import "Config.h"
@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNav];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"qqicon"];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [imageView addGestureRecognizer:recognizer];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor tanColor];
}

-(void)login{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"8a7c2136f86a95e256b67e73de4c1544" forKey:@"access_token"];
    
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:@"qq" forKey:@"weiboType"];
    [params setObject:@"3D30D2BF01AD011252695BCE71B89AFC" forKey:@"openId"];
    [data setObject:params forKey:@"params"];
    [parameters setObject:[data mj_JSONString] forKey:@"data"];
    
    [parameters setObject:@"E542B165-08ED-4529-AF7C-B15F8DE0B199" forKey:@"device"];
    
    [parameters setObject:@"iPhone 5" forKey:@"platform"];
    [parameters setObject:@"1" forKey:@"network"];
    [parameters setObject:@"568.000000" forKey:@"screen_height"];
    [parameters setObject:@"320.000000" forKey:@"screen_width"];
    [parameters setObject:@"1" forKey:@"system"];
    [parameters setObject:@"9.2" forKey:@"system_version"];
    [parameters setObject:@"4.4.0" forKey:@"version"];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_THIRD_LOGIN prefix:HLXAPI_PREFIX parameters:parameters success:^(NSURLSessionDataTask *task, id responseOBJ) {
        ResponseRootObject* obj = [ResponseRootObject mj_objectWithKeyValues:responseOBJ];
        if ([obj.ret isEqual:@"0"]) {
            User* user = [User mj_objectWithKeyValues:obj.data];
            [Config saveProfile:user];
            //侧边栏顶部更新
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"%@",error.domain);
    }];

}

-(void)initNav{
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_arrow_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(onClickleftMenuButton)];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"登 陆";
    self.navigationItem.titleView = title;
}

-(void)onClickleftMenuButton{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
