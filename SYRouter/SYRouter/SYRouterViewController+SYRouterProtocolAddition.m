//
//  SYRouterViewController+SYRouterProtocolAddition.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterViewController+SYRouterProtocolAddition.h"
#import "SYRouterNavigationController.h"

@implementation SYRouterViewController (SYRouterProtocolAddition)
- (void)SY_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    [self SY_jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil jumpStype:SYRouterJumpStyleOfPush];
}

- (void)SY_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStype:(SYRouterJumpStyle)jumpStype {
    SYRouterNavigationController *navigationController = (SYRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[SYRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStype];
    }
}

- (void)SY_jumpToViewControllerWithPageName:(NSString*)pageName
                                  otherParam:(NSDictionary*)otherParam
                                    animated:(BOOL)animated{
    SYRouterNavigationController *navigationController = (SYRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[SYRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithPageName:pageName otherParam:otherParam animated:animated];
    }
}

- (void)SY_jumpToViewControllerWithPageId:(NSString*)pageId
                                otherParam:(NSDictionary*)otherParam
                                  animated:(BOOL)animated {
    [self SY_jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:nil jumpStype:SYRouterJumpStyleOfPush];
}

- (void)SY_jumpToViewControllerWithPageId:(NSString*)pageId
                                otherParam:(NSDictionary*)otherParam
                                  animated:(BOOL)animated
                            targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                 jumpStype:(SYRouterJumpStyle)jumpStype {
    
    SYRouterNavigationController *navigationController = (SYRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[SYRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStype];
    }
}

- (void)SY_popoverPresentationControllerAnimated:(BOOL)animated {
    SYRouterNavigationController *navigationController = (SYRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[SYRouterNavigationController class]]) {
        [navigationController.router popoverPresentationControllerAnimated:animated];
    }else{
        if (self.jumpStyle == SYRouterJumpStyleOfPresent) {
            [self dismissViewControllerAnimated:animated completion:nil];
        }
    }
}

- (void)SY_jumpToViewControllerWithViewController:(UIViewController *)viewController
                                          animated:(BOOL)animated
                                    targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                         jumpStyle:(SYRouterJumpStyle)jumpStyle  {
    SYRouterNavigationController *navigationController = (SYRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[SYRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithViewController:viewController animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
    }
}


@end
