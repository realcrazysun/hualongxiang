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
@implementation NoticInfoTableViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(NSUInteger idx){
            return [NSString stringWithFormat:@"%@", HLXAPI_NOTICE];
        };
        self.objClass = [NoticeListInfoObject class];
    }
    return self;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* reuseIdentifier = @"cellOne";
    static NSString* reuseIdentifier2 = @"cellThree";
    static NSString* reuseIdentifier3 = @"cellAD";
    NoticeListInfoObject* object = self.objects[indexPath.row];
    NoticInfoTableViewCellType type = [self typeForRowAtIndexPath:indexPath];
    switch (type) {
        case NoticInfoTableViewCellOnePic:
        {
            DynamicInfoCellOnePic* cell = [[DynamicInfoCellOnePic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.titleLabel.text        = object.title;
            cell.nameLabel.text         = object.author;
            cell.readcountLabel.text    = object.views_num;
            [cell setImgUrl:[object.attaches[0] objectForKey:@"attachurl"]];
            return cell;
        }
        case NoticInfoTableViewCellThreePic:
        {
            DynamicInfoCellThreePic* cell = [[DynamicInfoCellThreePic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier2];
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
            DynamicInfoCellAD* cell = [[DynamicInfoCellAD alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
            cell.titleLabel.text        = object.title;
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
@end
