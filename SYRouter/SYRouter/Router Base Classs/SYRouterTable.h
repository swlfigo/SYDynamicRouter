//
//  SYRouterTable.h
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//读取Plist路由器中Controller信息

extern NSString *const SYRouterTablePageId;
extern NSString *const SYRouterTablePageName;
extern NSString *const SYRouterTableDescrption;

@interface SYRouterTable : NSObject

+ (SYRouterTable*)defaultRouterTable;

// 通过pageName，转化成pageId
- (NSString *)pageIdByPageName:(NSString *)pageName;

// 通过pageId，转化成pageName
- (NSString *)pageNameByPageId:(NSString *)pageId;

// 通过pageId，获取页面描述
- (NSString *)pageDescriptionByPageId:(NSString *)pageId;

// 通过pageID， 转化成viewController
- (UIViewController *)viewControllerByPageId:(NSString *)pageId;

// 通过pageName，转化成viewController
- (UIViewController *)viewControllerByPageName:(NSString *)pageName;

// 获取详细信息
- (NSDictionary *)pageDetailInfoByPageId:(NSString *)pageId;

// 获取详细信息
- (NSDictionary *)pageDetailInfoByPageName:(NSString *)pageName;


@end
