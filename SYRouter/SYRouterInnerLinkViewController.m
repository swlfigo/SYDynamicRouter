//
//  SYRouterInnerLinkViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterInnerLinkViewController.h"

@interface SYRouterInnerLinkViewController ()

@end

@implementation SYRouterInnerLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self addBackTitle:@"返回"];
}

-(void)setParam:(NSDictionary *)param{
    [super setParam:param];
    NSLog(@"%@ have Param ===============> ‼️‼️‼️ ",NSStringFromClass(self.class));
    NSLog(@"param:%@",param);
    
}
@end
