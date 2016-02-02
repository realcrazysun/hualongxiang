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
#define BottomH  50
#define BottomViewY (ScreenHeight - BottomH - 64)
#define EditViewY (ScreenHeight - [self.editView.textView measureHeight] - 64)
@interface DetailInfoViewController()<UIWebViewDelegate,UIScrollViewDelegate,UITextViewDelegate>
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
    
    NSLog(@"%f%f",self.view.frame.size.height,self.view.frame.size.width);
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
    [_HUD hide:YES afterDelay:15];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15]];
}

#pragma mark -- webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ( title && ![title isEqualToString:@""]) {
        self.navigationItem.title = title;
    }
    //点赞
    NSString* isping = [webView stringByEvaluatingJavaScriptFromString:@"isping"];
    [_replyView setLiked:[isping isEqualToString:@"1"]];
    
    [_webView.scrollView.mj_header endRefreshing];
    _HUD.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [_webView.scrollView.mj_header endRefreshing];
}

-(void)clickIcon{
    [_editView.textView resignFirstResponder];
    _emojiPageVC.view.hidden = NO;
    _editView.hidden = NO;
    [UIView transitionWithView:_editView duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        _editView.frame = CGRectMake(_editView.frame.origin.x, EditViewY-216, _editView.frame.size.width, _editView.frame.size.height);
    } completion:nil];
    
}

-(void)moreButtonClicked{
    
}
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
    //        NSLog(@"---");
    if (scrollView==_editView.textView) {
        return;
    }
    [self.editView.textView resignFirstResponder];
    [self hideEditView];
    self.replyView.hidden = NO;
    self.emojiPageVC.view.hidden = YES;
}
//-(void)clickWebView{
//    [self.editView.textView resignFirstResponder];
//    [self hideEditView];
//    self.replyView.hidden = NO;
//}

#pragma mark textview delegate
- (void)textDidUpdate:(NSNotification *)notification
{
    //    //    [self updateInputBarHeight];
    CGFloat inputbarHeight = [self appropriateInputbarHeight];
    
    //
    
    if (inputbarHeight != self.editView.frame.size.height) {
        CGFloat changeHeight = inputbarHeight-self.editView.frame.size.height;
        CGRect frame =  self.editView.frame;
        self.editView.frame = CGRectMake(frame.origin.x, frame.origin.y - changeHeight, frame.size.width, inputbarHeight);
        CGRect textViewFrame =  self.editView.textView.frame;
        NSLog(@"%f------%f----%f",inputbarHeight,textViewFrame.size.height,self.editView.frame.size.height);
        self.editView.textView.frame = CGRectMake(textViewFrame.origin.x, textViewFrame.origin.y , textViewFrame.size.width, textViewFrame.size.height+changeHeight);
        
        //        [self.view layoutIfNeeded];
    }
    
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

@end
