//
//  DetailInfoViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/23.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DetailInfoViewController.h"
@interface DetailInfoViewController()
@property(nonatomic,strong) UIWebView* webView;
@end

@implementation DetailInfoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];

    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hualongxiang.qianfanapi.com/v1_4/wap/view-thread?tid=12449377&isSeeMaster=0&replyOrder=0&viewpid=0"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]];
    [self.view addSubview:_webView];
}


- (void)backButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
