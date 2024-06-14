//
//  YPPMiddleWare.m
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import "YPPMiddlewareTask.h"
#import "YPPMiddleware.h"

@implementation YPPMiddleware
- (YPPMiddlewareTask *)use:(id)data {
    return [[YPPMiddlewareTask alloc] init];
}

@end
