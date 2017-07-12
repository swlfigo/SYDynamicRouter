//
//  SYRouterConstant.m
//  SYRouter
//
//  Created by Sylar on 2017/7/11.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterConstant.h"

NSString * const kSYRouterCallbackKey  = @"isCallbackMode";
NSString * const kSYRouterPageNameKey = @"pname";
NSString * const kSYRouterPageIdKey = @"pid";
NSString * const kSYRouterAPPKey = @"SY";
NSString * const kSYRouterActionTypeKey = @"type";

NSString * const kSYRouterActionInnerPage = @"inner_app";
NSString * const kSYRouterActionInnerWebPage = @"inner_web";
NSString * const kSYRouterActionOutsideWebPage = @"outside_web";
NSString * const kSYRouterActionOutsideApp = @"outside_app";

@implementation SYRouterConstant

//创建路由网址
+ (NSString*)innerWebURLWithURL:(NSString*)URL  title:(NSString*)title {
    if (!URL) {
        return @"";
    }
    
    if (!title) {
        title = @"";
    }
    return [NSString stringWithFormat:@"%@://goto?type=%@&pid=100005&webTitle=%@&url=%@",kSYRouterAPPKey,kSYRouterActionInnerWebPage,title,URL];
}

+ (NSString*)innerPageWithPageId:(NSString*)pageId  {
    if (!pageId) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@://goto?type=%@&pid=%@",kSYRouterAPPKey,kSYRouterActionInnerPage,pageId];
}

+ (NSMutableDictionary*)defaultInnerParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kSYRouterActionInnerPage forKey:kSYRouterActionTypeKey];
    return params;
}


@end
