//
//  DarenTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DarenTableViewController.h"
#import "DaRenTableViewCell.h"
#import "HLXApi.h"
#import "DaRenModel.h"
#import "AFHTTPSessionManagerTool.h"
#import "UserInfoViewController.h"
static NSString* darenIdentifer = @"darenIdentifer";

@interface DarenTableViewController()
@property(nonatomic,assign) DaRenType type;
@end
@implementation DarenTableViewController
-(instancetype)initWithType:(DaRenType) type{
    self = [super init];
    if(self){
        _type = type;
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_SIDE_HOT_USER_LIST];
        };
        self.objClass = [DaRenModel class];
        self.generateParams = ^(NSUInteger page){
            NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    self.tableView.rowHeight = [DaRenTableViewCell getCellHeight];
    [self.tableView registerClass:[DaRenTableViewCell class] forCellReuseIdentifier:darenIdentifer];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DaRenModel* model = self.objects[indexPath.row];
    
    DaRenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:darenIdentifer];
    
    [cell setData:model];
    if (indexPath.row < 3) {
        [cell setRankImg:@[@"icon_rank_one",@"icon_rank_two",@"icon_rank_three"][indexPath.row]];
    }else{
        //要加上这句 否则复用会有问题
        [cell setRankImg:@""];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DaRenModel* model = self.objects[indexPath.row];
    NSUInteger uid = model.user_id;
    UIStoryboard *userSB = [UIStoryboard storyboardWithName:@"UserInfo" bundle:nil];
    UserInfoViewController * controller = [userSB instantiateViewControllerWithIdentifier:@"userInfoViewController"];
    controller.uid = uid;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
