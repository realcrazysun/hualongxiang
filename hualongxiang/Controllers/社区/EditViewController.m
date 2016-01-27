//
//  EditViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/26.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "EditViewController.h"
#import "AllBlocksViewController.h"
#import "CommonDefines.h"
#import "UIColor+Wonderful.h"
#import "PlaceholderTextView.h"
#import "UIColor+Wonderful.h"
#import "Forum.h"
#import "AFHTTPSessionManagerTool.h"
#import "Config.h"
#import "MJExtension.h"
#import "HLXApi.h"
#import "Utils.h"
#import <MBProgressHUD.h>
#import "ResponseRootObject.h"
#import "LoginViewController.h"
#define LCGG_FID 103 //龙城茶座
@interface EditViewController()
@property(nonatomic,strong) UITextField* titleTextField;
@property(nonatomic,strong) PlaceholderTextView* contentTextView;
@property(nonatomic,strong) Subforum* subforum;
@property(nonatomic,strong) UILabel* navtitle;
@end

@implementation EditViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _subforum       = [Subforum new];
    _subforum.fid   = LCGG_FID;
    
    [self initNav];
    
    self.view.backgroundColor = [UIColor whiteSmoke];
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
    _titleTextField.placeholder = @" 请输入标题";
    [self.view addSubview:_titleTextField];
    
    CGFloat y =  CGRectGetMaxY(_titleTextField.frame);
    UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, 1)];
    sep.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sep];
    
    _contentTextView = [[PlaceholderTextView alloc] init];
    _contentTextView.frame = CGRectMake(0,CGRectGetMaxY(sep.frame),ScreenWidth, 400);
    _contentTextView.font = [UIFont systemFontOfSize:17];
    _contentTextView.placeholder = @"请输入内容";
    _contentTextView.backgroundColor = [UIColor whiteSmoke];
    [self.view addSubview:_contentTextView];
    
}

-(void)initNav{
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeft)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickRight)];
    
    _navtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _navtitle.font = [UIFont systemFontOfSize:19];
    _navtitle.textColor = [UIColor blackColor];
    _navtitle.backgroundColor = [UIColor clearColor];
    _navtitle.textAlignment = NSTextAlignmentCenter;
    _navtitle.text = @"龙城茶座▾";
    _navtitle.textColor = [UIColor dimGray];
    _navtitle.userInteractionEnabled = YES;
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitle)];
    [_navtitle addGestureRecognizer:recognizer];
    self.navigationItem.titleView = _navtitle;
    
}

-(void)clickLeft{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)clickRight{
    //没有图片 判断数据
    [_titleTextField resignFirstResponder];
    [_contentTextView resignFirstResponder];
    if ([_titleTextField.text isEqualToString:@""] || [_contentTextView.text isEqualToString:@""] ) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"标题或者内容为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
    }
    NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:_titleTextField.text forKey:@"title"];
    [params setObject:_contentTextView.text forKey:@"content"];
    [params setObject:[NSString stringWithFormat:@"%d",_subforum.fid ] forKey:@"fid"];
    [params setObject:@"" forKey:@"flashatt"];
    [data setObject:params forKey:@"params"];
    [parameters setObject:[data mj_JSONString] forKey:@"data"];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_FORUM_POSTNEWTHREAD prefix:HLXAPI_PREFIX parameters:parameters success:^(NSURLSessionDataTask * task, id responseObj) {
        //
        ResponseRootObject* obj = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if ([obj.ret isEqualToString:@"0"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            //打开对应社区界面
        }else{
            LoginViewController * loginViewController = [LoginViewController new];
            [self.navigationController pushViewController:loginViewController animated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请先登录" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            });
            
        }
        NSLog(@"%@",responseObj);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //
        MBProgressHUD *HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
        [HUD hide:YES afterDelay:1];
    }];
    //有图片
    //先上传图片  再发帖
}

-(void)clickTitle{
    
    AllBlocksViewController *vc = [AllBlocksViewController new];
    __block typeof(self) blockself = self;
    vc.chooseBlock = ^(Subforum* subforum){
        NSLog(@"excute block");
        blockself.subforum = subforum;
        blockself.navtitle.text = [NSString stringWithFormat:@"%@%@",subforum.name,@"▾"];
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
@end
