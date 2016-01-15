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
static NSString* reuseIdentifier = @"activityInfo";
@interface ActivityInfoController ()

@end

@implementation ActivityInfoController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(NSUInteger idx){
            return [NSString stringWithFormat:@"%@", HLXAPI_ACTIVITY];
        };
        self.objClass = [ActivityInfo class];
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

@end
