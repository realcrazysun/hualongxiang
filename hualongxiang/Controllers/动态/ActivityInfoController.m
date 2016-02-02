//
//  ActivityInfoController.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ActivityInfoController.h"
#import "HLXApi.h"
#import "CommonDefines.h"
#import "HotInfoModel.h"
#import "ActivityInfoTableViewCell.h"
#import "ActivityInfo.h"
#import "DetailInfoViewController.h"
#import "AFHTTPSessionManagerTool.h"
static NSString* reuseIdentifier = @"activityInfo";
@interface ActivityInfoController ()

@end

@implementation ActivityInfoController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_ACTIVITY];
        };
        self.objClass = [ActivityInfo class];
        self.generateParams = ^(NSUInteger page){
            NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
            [data setObject:params forKey:@"params"];
            [parameters setObject:[data mj_JSONString] forKey:@"data"];
            return parameters;
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 140;
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([ActivityInfoTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 查一下带参数forIndexPath有神么区别 sizeToFit是什么？
    ActivityInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell sizeToFit];
    ActivityInfo* info = self.objects[indexPath.row];
    [cell setModel:info];
    return cell;
}
#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityInfo* info = self.objects[indexPath.row];
    NSString* loadUrl = info.url;
    BOOL bottomBar = NO;
    if ([loadUrl isEqualToString:@""]) {
        loadUrl = [NSString stringWithFormat:HLXAPI_VIEW_THREAD,info.belong_id];
        bottomBar = YES;
    }
    DetailInfoViewController* controller = [[DetailInfoViewController alloc] init:bottomBar
                                                                          loadUrl:loadUrl
                                                                            liked:YES
                                                                        replyNums:0];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
