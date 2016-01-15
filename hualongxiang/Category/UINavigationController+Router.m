////
////  UINavigationController+Router.m
////  iosapp
////
////  Created by AeternChan on 10/14/15.
////  Copyright © 2015 oschina. All rights reserved.
////
////  用来截取WebView中得跳转
//#import "UINavigationController+Router.h"
//
////#import "UserDetailsViewController.h"
////#import "DetailsViewController.h"
////#import "ImageViewerController.h"
//#import "PostsViewController.h"
//#import "TweetsViewController.h"
//#import "TweetDetailsWithBottomBarViewController.h"
//
//#import "OSCNews.h"
//#import "OSCPost.h"
//#import "OSCTweet.h"
//
//#import <TOWebViewController.h>
//
//@implementation UINavigationController (Router)
//
//- (void)handleURL:(NSURL *)url
//{
//    NSString *urlString = url.absoluteString;
//    
//    //判断是否包含 oschina.net 来确定是不是站内链接
//    NSRange range = [urlString rangeOfString:@"oschina.net"];
//    if (range.length <= 0) {
//        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
//        webViewController.hidesBottomBarWhenPushed = YES;
//        [self pushViewController:webViewController animated:YES];
//    } else {
//        //站内链接
//        
//        urlString = [urlString substringFromIndex:7];
//        NSArray *pathComponents = [urlString pathComponents];
//        NSString *prefix = [pathComponents[0] componentsSeparatedByString:@"."][0];
//        UIViewController *viewController;
//        
//        if ([prefix isEqualToString:@"my"]) {
//            if (pathComponents.count == 2) {
//                // 个人专页 my.oschina.net/dong706
//                
//                viewController = [[UserDetailsViewController alloc] initWithUserName:pathComponents[1]];
//                viewController.navigationItem.title = @"用户详情";
//            } else if (pathComponents.count == 3) {
//                // 个人专页 my.oschina.net/u/12
//                
//                if ([pathComponents[1] isEqualToString:@"u"]) {
//                    viewController= [[UserDetailsViewController alloc] initWithUserID:[pathComponents[2] longLongValue]];
//                    viewController.navigationItem.title = @"用户详情";
//                }
//            } else if (pathComponents.count == 4) {
//                NSString *type = pathComponents[2];
//                if ([type isEqualToString:@"blog"]) {
//                    OSCNews *news = [OSCNews new];
//                    news.type = NewsTypeBlog;
//                    news.attachment = pathComponents[3];
//                    viewController = [[DetailsViewController alloc] initWithNews:news];
//                    viewController.navigationItem.title = @"博客详情";
//                } else if ([type isEqualToString:@"tweet"]){
//                    OSCTweet *tweet = [OSCTweet new];
//                    tweet.tweetID = [pathComponents[3] longLongValue];
//                    viewController = [[TweetDetailsWithBottomBarViewController alloc] initWithTweetID:tweet.tweetID];
//                    viewController.navigationItem.title = @"动弹详情";
//                }
//            } else if(pathComponents.count == 5) {
//                NSString *type = pathComponents[3];
//                if ([type isEqualToString:@"blog"]) {
//                    OSCNews *news = [OSCNews new];
//                    news.type = NewsTypeBlog;
//                    news.attachment = pathComponents[4];
//                    viewController = [[DetailsViewController alloc] initWithNews:news];
//                    viewController.navigationItem.title = @"博客详情";
//                }
//            }
//        } else if ([prefix isEqualToString:@"www"] || [prefix isEqualToString:@"m"]) {
//            //新闻,软件,问答
//            NSArray *urlComponents = [urlString componentsSeparatedByString:@"/"];
//            NSUInteger count = urlComponents.count;
//            if (count >= 3) {
//                NSString *type = urlComponents[1];
//                if ([type isEqualToString:@"news"]) {
//                    // 新闻
//                    // www.oschina.net/news/27259/mobile-internet-market-is-small
//                    
//                    int64_t newsID = [urlComponents[2] longLongValue];
//                    OSCNews *news = [OSCNews new];
//                    news.type = NewsTypeStandardNews;
//                    news.newsID = newsID;
//                    viewController = [[DetailsViewController alloc] initWithNews:news];
//                    viewController.navigationItem.title = @"资讯详情";
//                } else if ([type isEqualToString:@"p"]) {
//                    // 软件 www.oschina.net/p/jx
//                    
//                    OSCNews *news = [OSCNews new];
//                    news.type = NewsTypeSoftWare;
//                    news.attachment = urlComponents[2];
//                    viewController = [[DetailsViewController alloc] initWithNews:news];
//                    viewController.navigationItem.title = @"软件详情";
//                } else if ([type isEqualToString:@"question"]) {
//                    // 问答
//                    
//                    if (count == 3) {
//                        // 问答 www.oschina.net/question/12_45738
//                        
//                        NSArray *IDs = [urlComponents[2] componentsSeparatedByString:@"_"];
//                        if ([IDs count] >= 2) {
//                            OSCPost *post = [OSCPost new];
//                            post.postID = [IDs[1] longLongValue];
//                            viewController = [[DetailsViewController alloc] initWithPost:post];
//                            viewController.navigationItem.title = @"帖子详情";
//                        }
//                    } else if (count >= 4) {
//                        // 问答-标签 www.oschina.net/question/tag/python
//                        
//                        NSString *tag = urlComponents.lastObject;
//                        
//                        viewController = [PostsViewController new];
//                        ((PostsViewController *)viewController).generateURL = ^NSString * (NSUInteger page) {
//                            return [NSString stringWithFormat:@"%@%@?tag=%@&pageIndex=0&%@", OSCAPI_PREFIX, OSCAPI_POSTS_LIST, tag, OSCAPI_SUFFIX];
//                        };
//                        
//                        ((PostsViewController *)viewController).objClass = [OSCPost class];
//                        viewController.navigationItem.title = [tag stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                    }
//                } else if ([type isEqualToString:@"tweet-topic"]) {
//                    //话题
//                    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                    urlComponents = [urlString componentsSeparatedByString:@"/"];
//                    
//                    viewController = [[TweetsViewController alloc] initWithTopic:urlComponents[2]];
//                }
//            }
//        } else if ([prefix isEqualToString:@"static"]) {
//            ImageViewerController *imageViewerVC = [[ImageViewerController alloc] initWithImageURL:url];
//            
//            [self presentViewController:imageViewerVC animated:YES completion:nil];
//            
//            return;
//        }
//        if (viewController) {
//            [self pushViewController:viewController animated:YES];
//        } else {
//            TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
////            webViewController.hidesBottomBarWhenPushed = YES;
//            [self pushViewController:webViewController animated:YES];
//        }
//    }
//}
//
//
//@end
