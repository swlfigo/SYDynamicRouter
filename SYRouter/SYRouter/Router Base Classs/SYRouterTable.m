//
//  SYRouterTable.m
//  SYRouter
//
//  Created by Sylar on 2017/7/12.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouterTable.h"

NSString *const SYRouterTablePageId = @"id";
NSString *const SYRouterTablePageName = @"page";
NSString *const SYRouterTableDescrption = @"description";

@interface SYRouterTable ()
@property (nonatomic, strong) NSDictionary *routingTableDic;
@end

@implementation SYRouterTable

+ (SYRouterTable*)defaultRouterTable {
    static SYRouterTable *request = nil;
    if (!request) {
        request = [[SYRouterTable alloc] init];
    }
    return request;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"RouterTable.plist" ofType:nil];
        self.routingTableDic = [NSDictionary dictionaryWithContentsOfFile:file];
    }
    return self;
}

- (NSString *)pageIdByPageName:(NSString *)pageName {
    NSArray *allKeys = self.routingTableDic.allKeys;
    for (NSString *key in allKeys) {
        NSDictionary *detailDic = self.routingTableDic[key];
        NSString *tmpPageName = detailDic[SYRouterTablePageName];
        if (tmpPageName && [tmpPageName isKindOfClass:[NSString class]] && [tmpPageName isEqualToString:pageName]) {
            return key;
        }
    }
    return nil;
}

- (NSString *)pageNameByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSString *pageName = detailDic[SYRouterTablePageName];
    return pageName;
}

- (NSString *)pageDescriptionByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSString *pageDescription = detailDic[SYRouterTableDescrption];
    return pageDescription;
}


- (UIViewController *)viewControllerByPageId:(NSString *)pageId {
    NSString *pageName = [self pageNameByPageId:pageId];
    Class aClass = NSClassFromString(pageName);
    id vc = [[aClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

- (UIViewController *)viewControllerByPageName:(NSString *)pageName {
    Class aClass = NSClassFromString(pageName);
    id vc = [[aClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

- (NSDictionary *)pageDetailInfoByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSMutableDictionary *detailMDic = [NSMutableDictionary dictionaryWithDictionary:detailDic];
    [detailMDic setObject:pageId forKey:SYRouterTablePageId];
    return detailMDic;
}

- (NSDictionary *)pageDetailInfoByPageName:(NSString *)pageName {
    NSArray *allKeys = self.routingTableDic.allKeys;
    for (NSString *key in allKeys) {
        NSDictionary *detailDic = self.routingTableDic[key];
        NSString *tmpPageName = detailDic[@"page"];
        if (tmpPageName && [tmpPageName isKindOfClass:[NSString class]] && [tmpPageName isEqualToString:pageName]) {
            NSMutableDictionary *detailMDic = [NSMutableDictionary dictionaryWithDictionary:detailDic];
            [detailMDic setObject:key forKey:SYRouterTablePageId];
            return detailMDic;
        }
    }
    return nil;
}

@end
