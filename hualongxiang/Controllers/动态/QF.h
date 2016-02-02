//
//  QF.h
//  hualongxiang
//
//  Created by polyent on 16/1/22.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
@protocol PersonProtocol <JSExport>
-(void)callNative:(NSDictionary*)dic;
@end
@interface QF : NSObject<PersonProtocol>
@property(nonatomic,strong)UIViewController* fromVC;
@end
