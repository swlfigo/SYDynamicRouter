//
//  SYRouterGreenViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterGreenViewController.h"

@interface SYRouterGreenViewController ()

@end

@implementation SYRouterGreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackTitle:@"返回"];
}

-(void)setParam:(NSDictionary *)param{
    [super setParam:param];
    NSLog(@"%@ have Param ===============> ‼️‼️‼️ ",NSStringFromClass(self.class));
    
    if (param[@"bgColor"]) {
        NSLog(@"%@ Change its Color With Param ===============> ‼️‼️‼️ ",NSStringFromClass(self.class));
        self.view.backgroundColor = param[@"bgColor"];
    }
}

@end
