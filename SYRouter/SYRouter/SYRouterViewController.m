//
//  SYViewController.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterViewController.h"
#import "SYRouterViewController+SYRouterProtocolAddition.h"



//屏幕的参数
#define SY_SCREEN_SCALE        ([[UIScreen mainScreen] scale])
#define SY_SCREEN_BOUNDS       ([[UIScreen mainScreen] bounds])
#define SY_SCREEN_FRAME        ([[UIScreen mainScreen] applicationFrame])
#define SY_SCREEN_SIZE         ([[UIScreen mainScreen] bounds].size)
#define SY_SCREEN_SIZE_F       ([[UIScreen mainScreen] applicationFrame].size)
#define SY_SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SY_SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SY_SCREEN_HEIGHT_F     ([[UIScreen mainScreen] applicationFrame].size.height)


static inline bool isUsableDictionary(NSDictionary *dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    return NO;
}


@interface SYRouterViewController ()

@end

@implementation SYRouterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout=~UIRectEdgeTop;
        
        // 导航栏
        _customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SY_SCREEN_WIDTH, 64)];
        
        //标题栏
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SY_SCREEN_WIDTH, 44)];
        [_customNavigationBar addSubview:_navTitleLabel];
        _navTitleLabel.text = self.title;
        _navTitleLabel.textColor = [UIColor blackColor];
        _navTitleLabel.font = [UIFont systemFontOfSize:17];
        _navTitleLabel.backgroundColor = [UIColor clearColor];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        _customNaviagtionItem = [[UINavigationItem alloc] init];
        [_customNavigationBar pushNavigationItem:_customNaviagtionItem animated:NO];
        
        _customNavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                     NSFontAttributeName:[UIFont systemFontOfSize:17]};
        _customNavigationBar.clipsToBounds = YES;
        _customNavigationBar.barTintColor = [UIColor whiteColor];
        
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_customNavigationBar];
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:_customNavigationBar];
    
    CGFloat margin = 0;
    
    if (_customNaviagtionItem.leftBarButtonItem || _customNaviagtionItem.rightBarButtonItem) {
        margin = 70;
    }
    
    CGRect frame = _navTitleLabel.frame;
    frame.origin.x = margin;
    frame.size.width = SY_SCREEN_WIDTH - margin * 2;
    _navTitleLabel.frame = frame;
    
}

#pragma mark - 外部可实现的方法

/*
 * @brief 设置参数，去model化，统一传参类型。注意：在这里设置pageId不会发送开始统计。
 */
- (void)setParam:(NSDictionary *)param {
    _param = param;
}


#pragma mark - Navi 设置
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    //[_customNaviagtionItem setTitle:title];
    
    _navTitleLabel.text = title;
}

- (void)setTitleTextAttributes:(NSDictionary *)titleTextAttributes {
    if (isUsableDictionary(titleTextAttributes)) {
        UIColor *color = titleTextAttributes[NSForegroundColorAttributeName];
        if (color && [color isKindOfClass:[UIColor class]]) {
            _navTitleLabel.textColor = color;
        }
        
        UIFont *font = titleTextAttributes[NSFontAttributeName];
        if (font && [font isKindOfClass:[UIFont class]]) {
            _navTitleLabel.font = font;
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    _navTitleLabel.textColor = tintColor;
}




#pragma mark - 设置导航栏按钮


/**
 * 添加返回按钮
 * @param icon 按钮图片
 */
- (UIButton *)addBackIcon:(UIImage *)icon {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -13.5, 0, 20);
    
    
    [button addTarget:self action:@selector(SNS_pressBackAlphaButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [_customNaviagtionItem setLeftBarButtonItem:buttonItem animated:YES];
    
    return button;
}

/**
 * 添加返回按钮
 * @param title 左标题
 */
- (UIButton *)addBackTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 44 , 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(SNS_pressBackAlphaButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [_customNaviagtionItem setLeftBarButtonItem:buttonItem animated:YES];
    
    return button;
}

/**
 * 添加左按钮
 * @param icon 左按钮图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addLeftIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -13.5, 0, 20);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.leftBarButtonItem = buttonItem;
    
    return button;
}


/**
 添加左按钮
 @param icon 图片
 @param target 目标
 @param action 方法
 @param insets 图片位置
 */
- (UIButton *)addLeftIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action insets:(UIEdgeInsets)insets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.imageEdgeInsets = insets;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.leftBarButtonItem = buttonItem;
    
    return button;
}


/**
 * 添加左按钮
 * @param title 左标题
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addLeftTitle:(NSString *)title withTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.leftBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加左按钮
 * @param title 左标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 */
- (UIButton *)addLeftTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.leftBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加左按钮
 * @param title 左标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 * @param frame 按钮位置
 */
- (UIButton *)addLeftTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    button.frame = frame;
    
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.leftBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 20-5-4-2-1, 0, -20);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 * @param insets 图片位置
 */
- (UIButton *)addRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action insets:(UIEdgeInsets)insets{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.imageEdgeInsets = insets;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    
    return button;
}

/**
 * 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    
    //UI Todo
//    [button.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(button.mas_right).offset(3);
//    }];
    
    return button;
}

/**
 * 添加右按钮
 * @param title 右标题
 * @param target 目标
 * @param action 方法
 * @param titleColor 文字颜色
 * @param alpha 透明度
 */
- (UIButton *)addRightTitle:(NSString*)title withTarget:(id)target action:(SEL)action color:(UIColor *)titleColor alpha:(CGFloat)alpha {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    button.alpha = alpha;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    //UI Todo
//    [button.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(button.mas_right).offset(11);
//    }];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (alpha == 0.5) {
        buttonItem.enabled = NO;
    }
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    return button;
}



/**
 * 添加右按钮
 * @param icon 右图片
 * @param target 目标
 * @param action 方法
 */
- (UIButton *)JPAddRightIcon:(UIImage *)icon withTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, -20);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:@selector(SNS_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _customNaviagtionItem.rightBarButtonItem = buttonItem;
    
    return button;
}




#pragma mark - 事件

- (void)SNS_pressBackAlphaButtonUp:(UIButton *)button {
    [self SY_popoverPresentationControllerAnimated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 1;
    } completion:^(BOOL finished) {
        button.alpha = 1;
    }];
}

- (void)SNS_pressAlphaButtonDown:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 0.2f;
    } completion:^(BOOL finished) {
        button.alpha = 0.2f;
    }];
}

- (void)SNS_pressAlphaButtonCancel:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 1;
    } completion:^(BOOL finished) {
        button.alpha = 1;
    }];
}

@end
