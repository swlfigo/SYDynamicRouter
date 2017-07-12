//
//  SYRouter.m
//  SYRouter
//
//  Created by Sylar on 2017/7/11.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "SYRouter.h"
#import "SYRouterViewController.h"
static inline bool SYRouterIsUsableNSString(id aString, NSString *inequalString) {
    if (inequalString == nil) {
        if (aString && [aString isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    else {
        if (aString && [aString isKindOfClass:[NSString class]] && ![(NSString *)aString isEqualToString:inequalString]) {
            return YES;
        }
    }
    return NO;
}

@interface SYRouter ()
@property (nonatomic, weak) UINavigationController *navigator;
@end


@implementation SYRouter

+ (SYRouter*)defaultRouter {
    static SYRouter *request = nil;
    if (!request) {
        request = [[SYRouter alloc] init];
    }
    return request;
}

#pragma mark - get/set

- (SYRouterTable*)routerTable{
    if (!_routerTable) {
        _routerTable = [[SYRouterTable alloc] init];
    }
    return _routerTable;
}

#pragma mark - Public Methods

- (void)registWithNavigator:(UINavigationController *)navigator {
    self.navigator = navigator;
}

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url.scheme isEqualToString:kSYRouterAPPKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = [self paramWithURL:urlString];
    NSString *pid = param[kSYRouterPageIdKey];
    if (SYRouterIsUsableNSString(pid, @"")) {
        param[SYRouterTablePageId] = pid;
    }
    return [self viewControllerWithParams:param];
}

- (UIViewController*)viewControllerWithParams:(NSMutableDictionary *)params {
    if (!params) {
        return nil;
    }
    
    if (![[params allKeys] containsObject:kSYRouterPageIdKey]&&
        ![[params allKeys] containsObject:kSYRouterPageNameKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = params;
    NSString *type = param[kSYRouterActionTypeKey];
    NSString *pid = param[kSYRouterPageIdKey];
    
    if (SYRouterIsUsableNSString(pid, @"")) {
        param[SYRouterTablePageId] = pid;
    }else {
        if ([[params allKeys] containsObject:kSYRouterPageNameKey]) {
            pid  = [self.routerTable pageIdByPageName:[params objectForKey:kSYRouterPageNameKey]];
        }
        if (pid) {
            param[SYRouterTablePageId] = pid;
        }
    }
    
    if (type) {
        if ([type isEqualToString:kSYRouterActionInnerPage]||[type isEqualToString:kSYRouterActionInnerWebPage]) {          // 内部页面
            if (SYRouterIsUsableNSString(pid, @"")) {
                UIViewController *vc = [self.routerTable viewControllerByPageId:pid];
                if (vc) {
                    if ([vc isKindOfClass:[UIViewController class]]) {
                        if ([vc respondsToSelector:@selector(setPageId:)]) {
                            
                            [vc performSelector:@selector(setPageId:) withObject:pid];
                        }
                        if ([vc respondsToSelector:@selector(setPageName:)]) {
                            [vc performSelector:@selector(setPageName:) withObject:[self.routerTable pageNameByPageId:pid]];
                        }
                        if ([vc respondsToSelector:@selector(setPageDescription:)]) {
                            [vc performSelector:@selector(setPageDescription:) withObject:[self.routerTable pageDescriptionByPageId:pid]];
                        }
                        if ([vc respondsToSelector:@selector(setParam:)]) {
                            [vc performSelector:@selector(setParam:) withObject:param];
                        }
                        return vc;
                    }
                }
            }
        }
    }
    return nil;
}

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    return [self jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:SYRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    if (!pageName) {
        return NO;
    }
    NSString *pageId = [self.routerTable pageIdByPageName:pageName];
    return [self jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:SYRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    if (!pageId) {
        return NO;
    }
    return [self jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:SYRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(SYRouterJumpStyle)jumpStyle {
    
    if (!pageId) {
        return NO;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pageId forKey:kSYRouterPageIdKey];
    [params setObject:kSYRouterActionInnerPage forKey:kSYRouterActionTypeKey];
    
    if (otherParam) {
        [params addEntriesFromDictionary:otherParam];
    }
    
    UIViewController *controller =  [self viewControllerWithParams:params];
    return [self jumpToViewControllerWithViewController:controller animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
}

- (BOOL)jumpToViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(SYRouterJumpStyle)jumpStyle {
    
    if ([viewController isKindOfClass:[SYRouterViewController class]]) {
        SYRouterViewController *vc = (SYRouterViewController*)viewController;
        vc.targetCallBack = targetCallBack;
        vc.jumpStyle = jumpStyle;
    }
    if (viewController) {
        if (jumpStyle == SYRouterJumpStyleOfPush) {
            [self.navigator pushViewController:viewController animated:animated];
        }else if (jumpStyle == SYRouterJumpStyleOfPresent){
            [[[self.navigator viewControllers] lastObject] presentViewController:viewController animated:YES completion:nil];
        }
        return YES;
    }
    return NO;
}


- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(SYRouterJumpStyle)jumpStyle{
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url.scheme isEqualToString:kSYRouterAPPKey]) {
        return NO;
    }
    
    NSMutableDictionary *param = [self paramWithURL:urlString];
    NSString *type = param[kSYRouterActionTypeKey];
    NSString *pid = param[kSYRouterPageIdKey];
    if (SYRouterIsUsableNSString(pid, @"")) {
        param[SYRouterTablePageId] = pid;
    }
    
    if (otherParam) {
        [param addEntriesFromDictionary:otherParam];
    }
    
    if (type) {
        if ([type isEqualToString:kSYRouterActionInnerPage]||[type isEqualToString:kSYRouterActionInnerWebPage]) {          // 内部页面
            if (SYRouterIsUsableNSString(pid, @"")) {
                UIViewController *controller =  [self viewControllerWithParams:param];
                return [self jumpToViewControllerWithViewController:controller animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
            }
        }else if ([type isEqualToString:kSYRouterActionOutsideWebPage]) { // 外部网页
            __block BOOL canOpenUrl = NO ;
            NSString *openUrlString= param[@"url"];
            NSURL *openUrl = [NSURL URLWithString:openUrlString];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                    canOpenUrl = success;
                }];
            }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
#pragma clang diagnostic pop
            }
            return canOpenUrl;
        } else if ([type isEqualToString:kSYRouterActionOutsideApp]) { // 外部app
            __block BOOL canOpenUrl = NO ;
            NSString *openUrlString= param[@"url"];
            NSURL *openUrl = [NSURL URLWithString:openUrlString];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                    canOpenUrl = success;
                }];
            }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
#pragma clang diagnostic pop
            }
            return canOpenUrl;
        } else {
            
        }
    }
    return NO;
}

- (BOOL)popoverPresentationControllerAnimated:(BOOL)animated {
    if(self.navigator.viewControllers.count == 1){
        //        [self.navigator dismissViewControllerAnimated:animated completion:nil];

        //        self.navigator = nil;
    }else if(self.navigator.viewControllers.count > 1){
        [self.navigator popViewControllerAnimated:animated];
        return YES;
    }
    return YES;
}

#pragma mark - Private Methods


- (NSString*)urlEncodeWithString:(NSString*)string{
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)urlDecodeWithString:(NSString*)string{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)string,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
#pragma clang diagnostic pop
    return result;
}

- (NSString *)urlDecodeForPlusConvertToBlankWithString:(NSString*)string {
    NSString *result = [self urlDecodeWithString:string];
    result = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return result;
}

#pragma mark - 分割Param
//分割Param
- (NSMutableDictionary*)paramWithURL:(NSString*)URL {
    NSURL *url = [NSURL URLWithString:URL];
    if (![url.scheme isEqualToString:kSYRouterAPPKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSString *queryStr = [url query];
    for (NSString *paramStr in [queryStr componentsSeparatedByString:@"&"]) {
        NSArray *elts = [paramStr componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            continue;
        }
        
        NSString *valueStr = [elts lastObject];
        valueStr = [self urlDecodeForPlusConvertToBlankWithString:valueStr];
        
        NSString *keyStr = [elts firstObject];
        keyStr = [self urlDecodeForPlusConvertToBlankWithString:keyStr];
        
        [param setObject:valueStr forKey:keyStr];
    }
    NSString *pid = param[kSYRouterPageIdKey];
    if (SYRouterIsUsableNSString(pid, @"")) {
        param[SYRouterTablePageId] = pid;
    }
    return param;
}



@end
