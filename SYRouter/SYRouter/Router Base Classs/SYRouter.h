//
//  SYRouter.h
//  SYRouter
//
//  Created by Sylar on 2017/7/11.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYRouterConstant.h"
#import "SYRouterTable.h"

/* 使用连接跳转时候的拼接示例
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=inner_web&pid=100009999&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"]; 跳转内部web
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=inner_app&pid=100003&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"];跳转内部页面
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=outside_app&pid=100009999&webTitle%@&request=%@",@"hahah",@"InterCamera://wwww.baidu.com"];跳转外部app
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=outside_web&pid=100009999&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"];跳转外部web
 */


@interface SYRouter : NSObject

@property (nonatomic, strong) SYRouterTable *routerTable;
//路由器包含一个Navigator
@property (nonatomic, weak,readonly) UINavigationController *navigator;


+ (SYRouter*)defaultRouter;

- (void)registWithNavigator:(UINavigationController *)navigator;

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated;

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName
                              otherParam:(NSDictionary*)otherParam
                                animated:(BOOL)animated;

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam
                              animated:(BOOL)animated ;

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam
                              animated:(BOOL)animated
                        targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                             jumpStyle:(SYRouterJumpStyle)jumpStyle ;

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated
                           targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                jumpStyle:(SYRouterJumpStyle)jumpStyle;

- (BOOL)jumpToViewControllerWithViewController:(UIViewController *)viewController
                                      animated:(BOOL)animated
                                targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                     jumpStyle:(SYRouterJumpStyle)jumpStyle ;

- (BOOL)popoverPresentationControllerAnimated:(BOOL)animated ;

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString;

- (UIViewController*)viewControllerWithParams:(NSMutableDictionary *)params;


@end
