//
//  YPPMiddleWare.h
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import <YPPKoa/YPPMiddlewareTask.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPMiddleware : NSObject

- (YPPMiddlewareTask *)use:(id)data;
@end

NS_ASSUME_NONNULL_END
