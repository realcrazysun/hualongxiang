//
//  HotInfoTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/13.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HotInfoTableViewController.h"
#import "HotInfoTableViewCell.h"
#import "HLXApi.h"
#import "CommonDefines.h"
#import "HotInfoModel.h"
#import "DetailInfoViewController.h"
#import "AFHTTPSessionManagerTool.h"
static NSString* reuseIdentifier = @"hotInfoTableViewCell";

@implementation HotInfoTableViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_HOTINFO];
        };
        self.objClass = [HotInfoModel class];

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
//-(NSArray*)parse:(ResponseRootObject *)response{
//    NSArray* arr = response.data;
//    NSMutableArray* array = [NSMutableArray new];
//    for (int i = 0; i < arr.count; i++) {
//        HotInfoModel * model = [HotInfoModel mj_objectWithKeyValues:arr[i]];
//        [array addObject:model];
//    }
//    return array;
//}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[HotInfoTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.rowHeight = HotInfoCellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 查一下带参数forIndexPath有神么区别 sizeToFit是什么？
    HotInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell sizeToFit];
    HotInfoModel* model = self.objects[indexPath.row];
    HotInfoHeadModel* header = [HotInfoHeadModel mj_objectWithKeyValues:model.items.header];
    [cell setData:model.pushtime header:header news: model.items.body];
    typeof(self) __weak weakself = self;
    cell.tapImgBlock = ^{
        NSString* loadUrl = header.url;
        if ([loadUrl isEqualToString:@""]) {
            loadUrl = [NSString stringWithFormat:HLXAPI_VIEW_THREAD,header.dataid];
        }
        DetailInfoViewController * vc  = [[DetailInfoViewController alloc] init:YES loadUrl:loadUrl liked:NO replyNums:0];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    cell.tapViewBlock = ^(NSUInteger idx){
        HotInfoBodyModel* bodyModel = model.items.body[idx];
        NSString* loadUrl = bodyModel.url;
        if ([loadUrl isEqualToString:@""]) {
            loadUrl = [NSString stringWithFormat:HLXAPI_VIEW_THREAD,bodyModel.dataid];
        }
        DetailInfoViewController * vc  = [[DetailInfoViewController alloc] init:YES loadUrl:loadUrl liked:NO replyNums:0];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}


@end
