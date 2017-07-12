//
//  SYRouterMainViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterMainViewController.h"

@interface SYRouterMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *withoutParamButton;

@property (weak, nonatomic) IBOutlet UIButton *withParamButton;

@end

@implementation SYRouterMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *jmpWithOutP = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
    [jmpWithOutP setTitle:@"不带参数跳转" forState:UIControlStateNormal];
    [jmpWithOutP setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jmpWithOutP addTarget:self action:@selector(jumpWithoutParam:) forControlEvents:UIControlEventTouchUpInside];
    jmpWithOutP.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 120);
    [self.view addSubview:jmpWithOutP];
    
    
    UIButton *jmpWithP = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
    [jmpWithP setTitle:@"带参数跳转" forState:UIControlStateNormal];
    [jmpWithP setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jmpWithP addTarget:self action:@selector(jumpWithParam:) forControlEvents:UIControlEventTouchUpInside];
    jmpWithP.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 180);
    [self.view addSubview:jmpWithP];
    
    
    
    UIButton *jmpWithInnerURL = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
    [jmpWithInnerURL setTitle:@"内部网址跳转" forState:UIControlStateNormal];
    [jmpWithInnerURL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jmpWithInnerURL addTarget:self action:@selector(jumpWithInnerURLString:) forControlEvents:UIControlEventTouchUpInside];
    jmpWithInnerURL.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 240);
    [self.view addSubview:jmpWithInnerURL];
    
    
    UIButton *jmpWithOutsideURL = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
    [jmpWithOutsideURL setTitle:@"外部网址跳转" forState:UIControlStateNormal];
    [jmpWithOutsideURL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jmpWithOutsideURL addTarget:self action:@selector(jumpWithOutSideURLString:) forControlEvents:UIControlEventTouchUpInside];
    jmpWithOutsideURL.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 300);
    [self.view addSubview:jmpWithOutsideURL];
    
    self.navTitleLabel.text = @"首页";
    self.navTitleLabel.textColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
}

-(void)jumpWithoutParam:(UIButton*)sender{
    [self jumpViewControllerWithPageName:@"SYRouterGreyViewController" otherParam:nil animated:YES];
}

-(void)jumpWithParam:(UIButton*)sender{
    [self jumpViewControllerWithPageName:@"SYRouterGreenViewController" otherParam:@{@"bgColor":[UIColor greenColor]} animated:YES];
    
}

-(void)jumpWithInnerURLString:(UIButton*)sender{
    NSString *url = @"SY://goto?type=inner_app&pid=000003";
    [self jumpViewControllerWithUrlString:url otherParam:@{@"urlParam":url} animated:YES];
}

-(void)jumpWithOutSideURLString:(UIButton*)sender{
    NSString *url = @"SY://goto?type=outside_web&url=https://www.baidu.com";
    [self jumpViewControllerWithUrlString:url otherParam:@{@"urlParam":url} animated:YES];
}
//outside_web


//根据跳转进来的设置参数
-(void)setParam:(NSDictionary *)param{
    [super setParam:param];
    
}




@end
