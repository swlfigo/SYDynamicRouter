//
//  SYRouterConstant.h
//  SYRouter
//
//  Created by Sylar on 2017/7/11.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

//构造路由网址

FOUNDATION_EXTERN NSString * const kSYRouterPageNameKey ;
FOUNDATION_EXTERN NSString * const kSYRouterCallbackKey ;
FOUNDATION_EXTERN NSString * const kSYRouterPageIdKey ;
FOUNDATION_EXTERN NSString * const kSYRouterAPPKey;
FOUNDATION_EXTERN NSString * const kSYRouterActionTypeKey ;

FOUNDATION_EXTERN NSString * const kSYRouterActionInnerPage ;
FOUNDATION_EXTERN NSString * const kSYRouterActionInnerWebPage ;
FOUNDATION_EXTERN NSString * const kSYRouterActionOutsideWebPage ;
FOUNDATION_EXTERN NSString * const kSYRouterActionOutsideApp ;

//Controller 跳转方式 1 - Push , 2 - Present
typedef NS_ENUM(NSUInteger, SYRouterJumpStyle) {
    SYRouterJumpStyleOfPush = 1,
    SYRouterJumpStyleOfPresent
};


@protocol SNSRouterControllerProtocol <NSObject>
@property (nonatomic, strong) NSString        *pageId;                              // 页面id
@property (nonatomic, strong) NSString        *pageName;                            // 实现类的类名
@property (nonatomic, strong) NSString        *pageDescription;                     // 页面描述
@property (nonatomic, strong, readonly) NSDictionary *param;                          // 页面其他参数
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id responseObject);// 返回targetCallBack

@property (nonatomic, assign) SYRouterJumpStyle jumpStyle;                         // 页面当前跳转类型
/*
 * @brief 设置参数，去model化，统一传参类型。 每个C跳转时候如果需要参数传递，则传这个
 
 */
- (void)setParam:(NSDictionary *)param;

@end


@interface SYRouterConstant : NSObject

+ (NSString*)innerWebURLWithURL:(NSString*)URL  title:(NSString*)title;

+ (NSString*)innerPageWithPageId:(NSString*)pageId ;

+ (NSMutableDictionary*)defaultInnerParams;

@end
