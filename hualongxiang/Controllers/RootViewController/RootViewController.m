//
//  RootViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/9.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib
{
    NSLog(@"excute awakeFromNib");
    self.parallaxEnabled = NO;
    
    self.scaleContentView = YES;
    self.contentViewScaleValue = 0.9;
    self.scaleMenuView = NO;
    
    self.contentViewShadowEnabled = YES;
    self.contentViewShadowRadius = 4.5;
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
