//
//  SYRouterJumpProtocol.h
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SYRouterJumpProtocol <NSObject>

@optional
//Controller名字带参数跳转
- (void)jumpViewControllerWithPageName:(NSString*)pageName otherParam:(NSDictionary*)otherParam animated:(BOOL)animated;
//路由网址跳转
- (void)jumpViewControllerWithUrlString:(NSString*)urlString;
- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam;
- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated;
- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack ;
- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStype:(SYRouterJumpStyle)jumpStype;
//返回
- (void)popoverPresentationControllerAnimated:(BOOL)animated;


@end
