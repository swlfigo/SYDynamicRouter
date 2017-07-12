//
//  SYRouterViewController.h
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYRouterConstant.h"

@interface SYRouterViewController : UIViewController

@property (nonatomic, strong) NSString        *pageId;                              // 页面id
@property (nonatomic, strong) NSString        *pageName;                            // 实现类的类名
@property (nonatomic, strong) NSString        *pageDescription;                     // 页面描述
@property (nonatomic, strong, readonly) NSDictionary *param;                          // 页面其他参数
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id responseObject);// 返回targetCallBack
@property (nonatomic, assign) SYRouterJumpStyle jumpStyle;                         // 页面当前跳转类型

@property (nonatomic, strong) UINavigationBar *customNavigationBar; //自定义的NavigationBar

@property (nonatomic, strong) UINavigationItem *customNaviagtionItem; //NavigationItem

@property (nonatomic, strong) UILabel *navTitleLabel; // 导航栏标题栏


#pragma mark - 设置导航栏按钮

/**
 设置标题层视图
 
 @param title 标题层视图
 */
-(void)setTitle:(NSString *)title;

- (void)setTitleTextAttributes:(NSDictionary *)titleTextAttributes;

- (void)setTintColor:(UIColor *)tintColor;


#pragma mark - 子类相关的钩子函数，子类更加情况重写

/*
 * @brief 设置参数，去model化，统一传参类型。
 */
- (void)setParam:(NSDictionary *)param;



#pragma mark - 导航栏按钮
/**
 * @ref 添加返回按钮
 * @param icon 按钮图片
 */
- (UIButton *)addBackIcon:(UIImage *)icon;

/**
 * @ref 添加返回按钮
 * @param title 左标题
 */
- (UIButton *)addBackTitle:(NSString *)title;

/**
 * @ref 添加左按钮
 * @param icon 左按钮图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addLeftIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action;


/**
 @ref 添加左图片
 @param icon 左按钮图片
 @param target 目标
 @param action 方法
 @param insets 图片位置
 */
- (UIButton *)addLeftIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action insets:(UIEdgeInsets)insets;

/**
 * @ref 添加左按钮
 * @param title 左标题
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addLeftTitle:(NSString *)title withTarget:(id)target action:(SEL)action;

/**
 * 添加左按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 */
- (UIButton *)addLeftTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor;

/**
 * 添加左按钮
 * @param title 左标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 * @param frame 按钮位置
 */
- (UIButton *)addLeftTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor frame:(CGRect)frame;

/**
 * @ref 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action;

/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 * @param insets 图片位置
 */
- (UIButton *)addRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action insets:(UIEdgeInsets)insets;

/**
 * @ref 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action;

/**
 * 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor;

/**
 * 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 * @param alpha 透明度
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor alpha:(CGFloat)alpha;



/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 * @param frame 位置
 */
- (UIButton *)addRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action frame:(CGRect)frame;

/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)JPAddRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action;

#pragma mark -
#pragma mark 事件

/**
 * @ref 按下按钮事件，按钮显示半透明，默认为alpha=0.2
 * @param button 按钮
 */
- (void)SNS_pressAlphaButtonDown:(UIButton *)button;

/**
 * @ref 取消按下按钮事件，按钮显示半透明，默认为alpha=0.2
 * @param button 按钮
 */
- (void)SNS_pressAlphaButtonCancel:(UIButton *)button;



@end
