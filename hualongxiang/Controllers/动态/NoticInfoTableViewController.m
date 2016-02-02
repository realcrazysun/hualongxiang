//
//  NoticInfoTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "NoticInfoTableViewController.h"
#import "NoticeInfoObject.h"
#import "HLXApi.h"
#import "DynamicInfoCellOnePic.h"
#import "MJExtension.h"
#import "DynamicInfoCellThreePic.h"
#import "DynamicInfoCellAD.h"
#import "DetailInfoViewController.h"
#import "AFHTTPSessionManagerTool.h"

static NSString* reuseIdentifier = @"cellOne";
static NSString* reuseIdentifier2 = @"cellThree";
static NSString* reuseIdentifier3 = @"cellAD";

@interface NoticInfoTableViewController()
@end
@implementation NoticInfoTableViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_NOTICE];
        };
        
        self.objClass = [NoticeListInfoObject class];
        typeof(self) __weak weakself = self;
        self.generateParams = ^(NSUInteger page){
            NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInteger:0] forKey:@"last_post_id"];
            [params setObject:[NSNumber numberWithInteger:0] forKey:@"last_side_id"];
            [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
            [params setObject:[NSNumber numberWithLongLong:weakself.lastRefreshtime] forKey:@"last_refresh_time"];
            if (weakself.objects.count>0 && page > 1) {
                NoticeListInfoObject* object = weakself.objects[weakself.objects.count - 1];
                [params setObject:[NSNumber numberWithLongLong:[object.sort longLongValue]] forKey:@"last_time"];
            }else{
                [params setObject:[NSNumber numberWithInt:0] forKey:@"last_time"];
                
            }
            
            
            
            [data setObject:params forKey:@"params"];
            [parameters setObject:[data mj_JSONString] forKey:@"data"];
            return parameters;
        };
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[DynamicInfoCellOnePic class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[DynamicInfoCellThreePic class] forCellReuseIdentifier:reuseIdentifier2];
    [self.tableView registerClass:[DynamicInfoCellAD class] forCellReuseIdentifier:reuseIdentifier3];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoticeListInfoObject* object = self.objects[indexPath.row];
    NoticInfoTableViewCellType type = [self typeForRowAtIndexPath:indexPath];
    switch (type) {
        case NoticInfoTableViewCellOnePic:
        {
            DynamicInfoCellOnePic* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            cell.titleLabel.text        = object.title;
            cell.nameLabel.text         = object.author;
            cell.readcountLabel.text    = object.views_num;
            [cell setImgUrl:[object.attaches[0] objectForKey:@"attachurl"]];
            return cell;
        }
        case NoticInfoTableViewCellThreePic:
        {
            DynamicInfoCellThreePic* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
            cell.titleLabel.text        = object.title;
            cell.nameLabel.text         = object.author;
            cell.readcountLabel.text    = object.views_num;
            cell.timeLabel.text         = object.push_at;
            NSMutableArray* arr = [NSMutableArray new];
            for (int i = 0 ; i < object.attaches.count; i++) {
                [arr addObject:[object.attaches[i] objectForKey:@"attachurl"]];
            }
            [cell setImgArr:[arr copy]];
            return cell;
        }
        case NoticInfoTableViewCellAD:
        {
            DynamicInfoCellAD* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
            cell.titleLabel.text    = object.title;
            if (object.attaches&&object.attaches.count>0) {
                [cell setImgUrl:[object.attaches[0] objectForKey:@"attachurl"]];
                
            }
            return cell;
        }
        default:
            break;
    }
    
    DynamicInfoCellOnePic* cell = [[DynamicInfoCellOnePic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.titleLabel.text = @"";
    cell.nameLabel.text = @"";
    cell.readcountLabel.text = @"";
    
    return cell;
    
}

-(NSArray*)parse:(ResponseRootObject *)response{
    NoticeInfoObject* object = [NoticeInfoObject mj_objectWithKeyValues:response.data];
    return object.list;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticInfoTableViewCellType type = [self typeForRowAtIndexPath:indexPath];
    switch (type) {
        case NoticInfoTableViewCellOnePic:
            return 100;
        case NoticInfoTableViewCellThreePic:
            return 160;
        case NoticInfoTableViewCellAD:
            return 140;
        default:
            return 100;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(NoticInfoTableViewCellType)typeForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeListInfoObject* object = self.objects[indexPath.row];
    if([object.type isEqualToString:@"101"] && object.attaches.count == 1){
        return NoticInfoTableViewCellOnePic;
    }
    if([object.type isEqualToString:@"101"] && object.attaches.count > 1){
        return NoticInfoTableViewCellThreePic;
    }
#warning 广告类型暂时没仔细看规律
    if ([object.type isEqualToString:@"104"] || [object.type isEqualToString:@"301"] ) {
        return NoticInfoTableViewCellAD;
    }
    NSLog(@"%@---%@",object.type,object.title);
    return NoticInfoTableViewCellAD;
    
}
#pragma mark -- tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeListInfoObject* object = self.objects[indexPath.row];
    NSString* loadUrl = object.url;
    BOOL bottomBar = NO;
    if ([loadUrl isEqualToString:@""]) {
        loadUrl = [NSString stringWithFormat:HLXAPI_VIEW_THREAD,object.target_id];
        bottomBar = YES;
    }
    DetailInfoViewController* controller = [[DetailInfoViewController alloc] init:bottomBar
                                                                          loadUrl:loadUrl
                                                                            liked:YES
                                                                        replyNums:[object.replies_num intValue]];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
