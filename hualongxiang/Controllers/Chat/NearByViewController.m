//
//  NearByViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/27.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "NearByViewController.h"
#import "UIView+Util.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "NearByUser.h"
#import "AFHTTPSessionManagerTool.h"
#import "CLLocationManager+blocks.h"
#import "Utils.h"
#import <MBProgressHUD.h>
#import "CommonDefines.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
#import <CoreLocation/CoreLocation.h>
#import "UIView+Util.h"
#import "Config.h"
@interface NearByViewController()<CLLocationManagerDelegate>
@property (nonatomic, strong) NSArray *pointsArray;
@property (nonatomic, strong) NSArray *data;//附近的人信息
@property (nonatomic, strong) CLLocationManager * manager;
@end

@implementation NearByViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    self.title = @"雷达";
    
    XHRadarView *radarView = [[XHRadarView alloc] initWithFrame:self.view.bounds];
    radarView.frame = self.view.frame;
    radarView.dataSource = self;
    radarView.delegate = self;
    radarView.radius = 250;
    radarView.backgroundColor = [UIColor colorWithRed:0.251 green:0.329 blue:0.490 alpha:1];
    radarView.backgroundImage = [UIImage imageNamed:@"radar_background"];
    radarView.labelText = @"正在搜索附近的目标";
    [self.view addSubview:radarView];
    _radarView = radarView;
    
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-39, self.view.center.y-39, 78, 78)];
    avatarView.layer.cornerRadius = 39;
    avatarView.layer.masksToBounds = YES;
    //TODO
    [avatarView loadPortraitWithNSString:[Config userIconUrl]];
    
    [_radarView addSubview:avatarView];
    [_radarView bringSubviewToFront:avatarView];
    
    //目标点位置
    _pointsArray = @[
                     @[@6, @90],
                     @[@-140, @108],
                     @[@-83, @140],
                     @[@-25, @142],
                     @[@60, @111],
                     @[@170, @180],
                     @[@150, @145],
                     
                     @[@25, @144],
                     @[@170, @180],
                     
                     @[@95, @109],
                     @[@170, @180],
                     @[@125, @112],
                     @[@-150, @165],
                     @[@-7, @160],
                     ];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 20, 70, 30);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitle:@"退出" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setCornerRadius:5];
    [backBtn setBorderWidth:1 andColor:[UIColor whiteColor]];
    [self.view addSubview:backBtn];
    
//    _manager = [CLLocationManager updateManagerWithAccuracy:50.0 locationAge:15.0 authorizationDesciption:CLLocationUpdateAuthorizationDescriptionWhenInUse];
//    
//    if ([CLLocationManager isLocationUpdatesAvailable]) {
//        [_manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
//            NSLog(@"Our new location: %@", location);
//            *stopUpdating = YES;
          //    }
//}];
    [self initializeLocationService];
    
   
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSMutableDictionary* paremeters = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"longitude"];
    [params setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"latitude"];
    [data setObject:params forKey:@"params"];
    [paremeters setObject:[data mj_JSONString] forKey:@"data"];
    typeof(self) __weak weakSelf = self;
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_SIDE_NEARUSERLIST prefix:HLXAPI_PREFIX parameters:paremeters success:^(NSURLSessionDataTask * task, id responseObject) {
        //
        ResponseRootObject* model = [ResponseRootObject mj_objectWithKeyValues:responseObject];
        if (![model.ret isEqualToString:@"0"]) {
            NSLog(@"数据返回异常");
            ShowLoginExpireInfo
            return ;
        }
        _data = model.data;
        [weakSelf startUpdatingRadar];
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        MBProgressHUD *HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
        [HUD hide:YES afterDelay:1];
    }];
    [_manager stopUpdatingLocation];

}
- (void)initializeLocationService {
    // 初始化定位管理器
    _manager = [[CLLocationManager alloc] init];
    // 设置代理
    _manager.delegate = self;
    // 设置定位精确度到米
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _manager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_manager requestAlwaysAuthorization];
    }
    
    [_manager startUpdatingLocation];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#warning 动画放在ViewDidload中还不执行了
    [self.radarView scan];
    
}

-(void)clickBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods
- (void)startUpdatingRadar {
    typeof(self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.radarView.labelText = [NSString stringWithFormat:@"搜索已完成，共找到%lu个目标", (unsigned long)weakSelf.pointsArray.count];
        [weakSelf.radarView show];
    });
}

#pragma mark - XHRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(XHRadarView *)radarView {
    return 5;
}
- (NSInteger)numberOfPointsInRadarView:(XHRadarView *)radarView {
//    return [self.data count];
    return 7;
}
- (UIView *)radarView:(XHRadarView *)radarView viewForIndex:(NSUInteger)index {
    NearByUser* user = [NearByUser mj_objectWithKeyValues:_data[index]];
    CGFloat width = 80;
    CGFloat height = 70;
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 50, 50)];
    [imageView loadPortraitWithNSString:user.user_icon];
    [imageView setCornerRadius:25];
    [pointView addSubview:imageView];
    
    CGFloat labelY = CGRectGetMaxY(imageView.frame)+5;
    CGFloat genderIconWH = 15;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, width - genderIconWH, height - labelY)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.text = user.user_name;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [pointView addSubview:label];
    
    UIImageView*  gender = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), height - genderIconWH, genderIconWH, genderIconWH)];
    if (user.user_gender == 0) {
        gender.image = [UIImage imageNamed:@"userinfo_gender_female"];
        
    }else{
        gender.image = [UIImage imageNamed:@"userinfo_gender_male"];
    }
    
    [pointView addSubview:gender];
    return pointView;
}
- (CGPoint)radarView:(XHRadarView *)radarView positionForIndex:(NSUInteger)index {
    NSArray *point = [self.pointsArray objectAtIndex:index];
    return CGPointMake([point[0] floatValue], [point[1] floatValue]);
}

#pragma mark - XHRadarViewDelegate

- (void)radarView:(XHRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex:%lu", (unsigned long)index);
    
}

@end
