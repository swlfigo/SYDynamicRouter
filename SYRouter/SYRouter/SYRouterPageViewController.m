//
//  SYRouterPageViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterPageViewController.h"
#import "SYRouterViewController+SYRouterProtocolAddition.h"
@interface SYRouterPageViewController ()

@end

@implementation SYRouterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 
#pragma mark - 跳转协议
- (void)jumpViewControllerWithPageName:(NSString*)pageName otherParam:(NSDictionary*)otherParam animated:(BOOL)animated{
    [self SY_jumpToViewControllerWithPageName:pageName otherParam:otherParam animated:animated];
}

- (void)jumpViewControllerWithUrlString:(NSString*)urlString{
    [self jumpViewControllerWithUrlString:urlString otherParam:nil];
}

- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam{
    [self jumpViewControllerWithUrlString:urlString otherParam:otherParam animated:YES];
}

- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated{
    [self jumpViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil];
}

- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack{
    [self jumpViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStype:SYRouterJumpStyleOfPush];
}

- (void)jumpViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStype:(SYRouterJumpStyle)jumpStype{
    [self SY_jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStype:jumpStype];
}

- (void)popoverPresentationControllerAnimated:(BOOL)animated{
    [self SY_popoverPresentationControllerAnimated:animated];
}

@end
