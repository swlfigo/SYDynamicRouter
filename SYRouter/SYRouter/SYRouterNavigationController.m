//
//  SYRouterNavigationController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterNavigationController.h"

@interface SYRouterNavigationController ()

@end

@implementation SYRouterNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (SYRouter*)router {
    if (!_router) {
        _router = [[SYRouter alloc] init];
    }
    return _router;
}

/*
 * @brief 设置参数，去model化，统一传参类型。
 */
- (void)setParam:(NSDictionary *)param {
    _param = param;
}

#pragma mark - Init methods （初始化方法）

-(instancetype)initWithJumpViewControllerParams:(NSMutableDictionary*)params{
    return [self initWithJumpController:[self rootViewControllerWithParams:params]];
}

-(instancetype)initWithJumpURL:(NSString*)jumpURL {
    UIViewController *rootViewController = [self.router viewControllerWithUrlString:jumpURL];
    return [self initWithJumpController:rootViewController];
}

-(instancetype)initWithJumpController:(UIViewController*)rootController {
    if (self=[super initWithRootViewController:rootController]) {
        self.navigationBarHidden = YES;
        [self.router registWithNavigator:self];
    }
    return self;
}

- (UIViewController*)rootViewControllerWithParams:(NSMutableDictionary*)params {
    UIViewController *rootViewController = [self.router viewControllerWithParams:params];
    return rootViewController;
}
@end
