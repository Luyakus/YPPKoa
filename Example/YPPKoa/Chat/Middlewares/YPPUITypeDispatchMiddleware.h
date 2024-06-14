//
//  YPPUITypeDispatchMiddleware.h
//  YPPKoa
//
//  Created by DZ0400843 on 2021/9/2.
//
#import "YPPUITypeModelPredicate.h"
#import <YPPKoa/YPPMiddleware.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPUITypeDispatchMiddleware : YPPMiddleware
- (void)addPredicate:(YPPUITypeModelPredicate *)prediccate;
@end

NS_ASSUME_NONNULL_END
