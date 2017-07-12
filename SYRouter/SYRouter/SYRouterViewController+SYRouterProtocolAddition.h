//
//  SYRouterViewController+SYRouterProtocolAddition.h
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterViewController.h"
#import "SYRouter.h"
@interface SYRouterViewController (SYRouterProtocolAddition)

- (void)SY_jumpToViewControllerWithUrlString:(NSString*)urlString
                                   otherParam:(NSDictionary*)otherParam
                                     animated:(BOOL)animated;

- (void)SY_jumpToViewControllerWithUrlString:(NSString*)urlString
                                   otherParam:(NSDictionary*)otherParam
                                     animated:(BOOL)animated
                               targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                    jumpStype:(SYRouterJumpStyle)jumpStype;

- (void)SY_jumpToViewControllerWithPageName:(NSString*)pageName
                                  otherParam:(NSDictionary*)otherParam
                                    animated:(BOOL)animated;

- (void)SY_jumpToViewControllerWithPageId:(NSString*)pageId
                                otherParam:(NSDictionary*)otherParam
                                  animated:(BOOL)animated;

- (void)SY_jumpToViewControllerWithPageId:(NSString*)pageId
                                otherParam:(NSDictionary*)otherParam
                                  animated:(BOOL)animated
                            targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                 jumpStype:(SYRouterJumpStyle)jumpStype;

- (void)SY_jumpToViewControllerWithViewController:(UIViewController *)viewController
                                          animated:(BOOL)animated
                                    targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                         jumpStyle:(SYRouterJumpStyle)jumpStyle;


- (void)SY_popoverPresentationControllerAnimated:(BOOL)animated;


@end
