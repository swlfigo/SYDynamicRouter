//
//  SYRouterGreyViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterGreyViewController.h"

@interface SYRouterGreyViewController ()

@end

@implementation SYRouterGreyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackTitle:@"返回"];
    
}

-(void)setParam:(NSDictionary *)param{
    [super setParam:param];
    NSLog(@"%@ No Param ===============> ‼️‼️‼️ ",NSStringFromClass(self.class));
    self.view.backgroundColor = [UIColor grayColor];
}



@end
