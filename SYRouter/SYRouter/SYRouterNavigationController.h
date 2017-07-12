//
//  SYRouterNavigationController.h
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYRouterConstant.h"
#import "SYRouter.h"

@interface SYRouterNavigationController : UINavigationController<SNSRouterControllerProtocol>

@property (nonatomic, strong) SYRouter *router;
@property (nonatomic, strong) NSString        *pageId;                              // 页面id
@property (nonatomic, strong) NSString        *pageName;                            // 实现类的类名
@property (nonatomic, strong) NSString        *pageDescription;                     // 页面描述
@property (nonatomic, strong) NSDictionary    *param;                               // 页面其他参数
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id responseObject);// 返回targetCallBack
@property (nonatomic, assign) SYRouterJumpStyle jumpStyle;                         // 页面当前跳转类型




/**
 *  初始化方法
 *
 *  @param jumpURL 传递的内部页面链接地址，指定初始化跳转界面
 *
 *  示例 jumpURL = @"hls://goto?type=inner_app&pid=100001"
 */
-(instancetype)initWithJumpURL:(NSString*)jumpURL;


-(instancetype)initWithJumpViewControllerParams:(NSMutableDictionary*)params;



@end
