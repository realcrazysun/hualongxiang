//
//  DetailInfoViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/23.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "ReplyView.h"
#import "EditViewWithGrowingText.h"
#import "CommonDefines.h"
#import "EmojiPageVC.h"
#import <MJRefresh.h>
#import "Utils.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "SDPhotoBrowser.h"
#import "QF.h"
#import "UserInfoViewController.h"
#define BottomH  50
#define BottomViewY (ScreenHeight - BottomH - 64)
#define EditViewY (ScreenHeight - [self.editView.textView measureHeight] - 64)
@interface DetailInfoViewController()<UIWebViewDelegate,UIScrollViewDelegate,UITextViewDelegate,SDPhotoBrowserDelegate>
{
    BOOL _liked;
    BOOL _showBottom;
    NSUInteger _replyNums;
    NSString* _loadUrl;
}
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic,strong) ReplyView* replyView;
@property(nonatomic,strong) EditViewWithGrowingText* editView;
@property(nonatomic,strong) EmojiPageVC* emojiPageVC;
@property(nonatomic,strong) MBProgressHUD *HUD;
@property(nonatomic,strong) NSArray *contentImages;
@end

@implementation DetailInfoViewController
-(instancetype)init:(BOOL)showBottom loadUrl:(NSString *)loadUrl liked:(BOOL)liked replyNums:(NSUInteger)replyNums {
    self = [super init];
    if(self){
        _liked = liked;
        _replyNums = replyNums;
        _loadUrl = loadUrl;
        _showBottom = showBottom;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_arrow_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self action:@selector(backButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_share_collapse"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(moreButtonClicked)];
    
    //    [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
    //
    CGRect frame = self.view.frame;
    CGRect webViewF = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - BottomH);
    _webView = [[UIWebView alloc] initWithFrame:webViewF];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self loadRequest:_loadUrl];
    typeof(self) __weak weakself = self;
    _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadRequest:_loadUrl];
    }];
    
    [self.view addSubview:_webView];
    
    if (!_showBottom) {
        return;
    }
    _replyView = [[ReplyView alloc] initWithFrame:CGRectMake(0, BottomViewY, self.view.frame.size.width, BottomH) liked:_liked replyNums:_replyNums];
    _replyView.clickContainer = ^{
        [weakself.editView.textView becomeFirstResponder];
    };
    [self.view addSubview:_replyView];
    [self.view bringSubviewToFront:_replyView];
    
    _editView = [[EditViewWithGrowingText alloc] initWithFrame:CGRectMake(0, EditViewY, self.view.frame.size.width, BottomH)];
    _editView.hidden = YES;
    
    _editView.emojiIcon .userInteractionEnabled = YES;
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIcon)];
    [_editView.emojiIcon addGestureRecognizer:recognizer];
    
    _editView.textView.delegate = self;
    [self.view addSubview:_editView];
    
    
    _emojiPageVC = [[EmojiPageVC alloc] initWithTextView:_editView.textView];
    [self.view addSubview:_emojiPageVC.view];
    _emojiPageVC.view.hidden = YES;
    _emojiPageVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"emojiPage": _emojiPageVC.view};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[emojiPage(216)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[emojiPage]|" options:0 metrics:nil views:views]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidUpdate:)    name:UITextViewTextDidChangeNotification object:nil];
    
}
-(void)loadRequest:(NSString*)url{
    _HUD = [Utils createHUD];
    //    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.labelText = @"网页加载中";
    [_HUD hide:YES afterDelay:10];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]];
}

-(void)clickIcon{
    [_editView.textView resignFirstResponder];
    _emojiPageVC.view.hidden = NO;
    _editView.hidden = NO;
    [UIView transitionWithView:_editView duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        _editView.frame = CGRectMake(_editView.frame.origin.x, EditViewY-216, _editView.frame.size.width, _editView.frame.size.height);
    } completion:nil];
    
}
/**
 *  导航栏右侧按钮点击事件
 */
-(void)moreButtonClicked{
    
}
/**
 *  回退按钮点击
 */
- (void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _editView.hidden = NO;
    [UIView transitionWithView:_editView duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        _editView.frame = CGRectMake(_editView.frame.origin.x, EditViewY-keyboardBounds.size.height, _editView.frame.size.width, _editView.frame.size.height);
    } completion:nil];
    
    
    //    _emojiPageVC.view.hidden = YES;
    //    _isEmojiPageOnScreen = NO;
    //    [_editingBar.inputViewButton setImage:[UIImage imageNamed:@"toolbar-emoji2"] forState:UIControlStateNormal];
    
    //    [self setBottomBarHeight];
}
-(void)hideEditView{
    _editView.hidden = YES;
    [UIView transitionWithView:_editView duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        _editView.frame = CGRectMake(_editView.frame.origin.x, EditViewY, _editView.frame.size.width, _editView.frame.size.height);
    } completion:nil];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    //   //
    //    [self setBottomBarHeight];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_editView.textView) {
        return;
    }
    [self.editView.textView resignFirstResponder];
    [self hideEditView];
    self.replyView.hidden = NO;
    self.emojiPageVC.view.hidden = YES;
}


- (CGFloat)appropriateInputbarHeight
{
    CGFloat height = 0;
    CGFloat minimumHeight = [self minimumInputbarHeight];
    CGFloat newSizeHeight = [self.editView.textView measureHeight];
    CGFloat maxHeight     = self.editView.textView.maxHeight;
    
    self.editView.textView.scrollEnabled = newSizeHeight >= maxHeight;
    
    if (newSizeHeight < minimumHeight) {
        height = minimumHeight;
    } else if (newSizeHeight < self.editView.textView.maxHeight) {
        height = newSizeHeight;
    } else {
        height = self.editView.textView.maxHeight;
    }
    
    return roundf(height);
}

- (CGFloat)minimumInputbarHeight
{
    return _editView.intrinsicContentSize.height;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //标题修改
    NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ( title && ![title isEqualToString:@""]) {
        self.navigationItem.title = title;
    }
    //是否点赞
    NSString* isping = [webView stringByEvaluatingJavaScriptFromString:@"isping"];
    [_replyView setLiked:[isping isEqualToString:@"1"]];
    
    [_webView.scrollView.mj_header endRefreshing];
    _HUD.hidden = YES;
    
    [self addMainContentImgEvent];

    [self addUserIconEvent];
    
    //调整字号
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
//    [webView stringByEvaluatingJavaScriptFromString:str];
#warning 应该是zepto lazyload 插件捣鬼 懒加载 大图  naturl 属性取出 放至 _contentImages
    //貌似可以用zepto 图片点击事件处理
//    static  NSString * const jsGetImages =
//    @"function getImages(){\
//    var ret = new Array();\
//    var objs = $(\".content_article\").find(\"img\");\
//    $.each(objs, function(index, item){\
//    QF.callLog(item.getAttribute(\'naturl\'));\
//    ret.push(item.getAttribute(\'naturl\'));\
//    item.onclick=function(){\
//    QF.callLog(this.src);\
//    document.location= \"myweb:imageClick:\"+index+\":\"+this.src;\
//    };\
//    });\
//    return ret;\
//    }";
//    //绑定图片点击事件
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//        [context evaluateScript:jsGetImages];
//        context.exceptionHandler=^(JSContext *context, JSValue *exception){
//            NSLog(@"JS Error :%@",exception);
//        };
//        //打印日志绑定
//        QF* qf = [[QF alloc] init];
//        context[@"QF"] = qf;
//
//        JSValue* value = [context[@"getImages"] callWithArguments:@[]];
//        //        JSValue* value = [context evaluateScript:@"getImages"];
//        NSArray* array = [value toArray];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _contentImages = array;
//        });
//    });
}

//内容图片点击事件
-(void)addMainContentImgEvent{
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var ret = new Array();\
    var objs = $(\".content_article\").find(\"img\");\
    $.each(objs, function(index, item){\
    QF.callLog(item.getAttribute(\'naturl\'));\
    ret.push(item.getAttribute(\'naturl\'));\
    item.onclick=function(){\
    QF.callLog(this.src);\
    document.location= \"myweb:imageClick:\"+index+\":\"+this.src;\
    };\
    });\
    return ret;\
    }";
    //绑定图片点击事件
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        [context evaluateScript:jsGetImages];
        context.exceptionHandler=^(JSContext *context, JSValue *exception){
            NSLog(@"JS Error :%@",exception);
        };
        //打印日志绑定
        QF* qf = [[QF alloc] init];
        context[@"QF"] = qf;
        
        JSValue* value = [context[@"getImages"] callWithArguments:@[]];
        //        JSValue* value = [context evaluateScript:@"getImages"];
        NSArray* array = [value toArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            _contentImages = array;
        });
    });

}
- (void)addUserIconEvent{
    static  NSString * const jsGetUserIcon =
    @"function jsGetUserIcon(){\
    var objs = $(\"a\");\
    $.each(objs, function(index, item){\
    QF.callLog(item.dataset.uid);\
    if(!item.dataset.uid){\
    }else{\
    item.onclick=function(){\
    document.location= \"myweb:userIconClick:\"+item.dataset.uid;\
    }};\
    });\
    }";
    //绑定图片点击事件
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        [context evaluateScript:jsGetUserIcon];
        context.exceptionHandler=^(JSContext *context, JSValue *exception){
            NSLog(@"JS Error :%@",exception);
        };
        //打印日志绑定
        QF* qf = [[QF alloc] init];
        context[@"QF"] = qf;
        
        JSValue* value = [context[@"jsGetUserIcon"] callWithArguments:@[]];
//        NSArray* array = [value toArray];
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
    });

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
//    NSLog(@"%@",requestString);
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSArray* splitArr = [requestString componentsSeparatedByString:@":"];
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = [(NSString*)splitArr[2] intValue];
        browser.sourceImagesContainerView = self.webView;
        browser.imageCount = self.contentImages.count;
        browser.delegate = self;
        [browser show];
        return NO;
        
    }else if([requestString hasPrefix:@"myweb:userIconClick:"]){
        
        NSArray* splitArr = [requestString componentsSeparatedByString:@":"];
        UIStoryboard *userSB = [UIStoryboard storyboardWithName:@"UserInfo" bundle:nil];
        UserInfoViewController * controller = [userSB instantiateViewControllerWithIdentifier:@"userInfoViewController"];
        controller.uid = [(NSString*)splitArr[2] intValue];;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [_webView.scrollView.mj_header endRefreshing];
}

#pragma mark -- SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.contentImages[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}
#pragma mark textview delegate
- (void)textDidUpdate:(NSNotification *)notification
{
    //    //    [self updateInputBarHeight];
    CGFloat inputbarHeight = [self appropriateInputbarHeight];
    
    if (inputbarHeight != self.editView.frame.size.height) {
        CGFloat changeHeight = inputbarHeight-self.editView.frame.size.height;
        CGRect frame =  self.editView.frame;
        self.editView.frame = CGRectMake(frame.origin.x, frame.origin.y - changeHeight, frame.size.width, inputbarHeight);
        CGRect textViewFrame =  self.editView.textView.frame;
        self.editView.textView.frame = CGRectMake(textViewFrame.origin.x, textViewFrame.origin.y , textViewFrame.size.width, textViewFrame.size.height+changeHeight);
        
        //        [self.view layoutIfNeeded];
    }
    
}

@end
