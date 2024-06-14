//
//  YPPUITypeDispatchMiddleware.m
//  YPPKoa
//
//  Created by DZ0400843 on 2021/9/2.
//

#import "YPPUITypeDispatchMiddleware.h"
@interface YPPUITypeDispatchMiddleware()
@property (nonatomic, strong) NSMutableArray <YPPUITypeModelPredicate *> *predicates;
@end
@implementation YPPUITypeDispatchMiddleware
- (instancetype)init {
    if (self = [super init]) {
        self.predicates = @[].mutableCopy;
    }
    return self;
}

- (void)addPredicate:(YPPUITypeModelPredicate *)prediccate {
    [self.predicates addObject:prediccate];
}

- (YPPMiddlewareTask *)use:(id)data {
    YPPMiddlewareTask *task = [YPPMiddlewareTask excute:^(YPPMiddlewareTask * _Nonnull it) {
        id mapData = data;
        for (YPPUITypeModelPredicate *predicate in self.predicates) {
            if ([predicate canAccept:data]) {
                mapData = [predicate map:data];
                break;
            }
        }
        [it onDone:mapData isFinal:NO];
    }];
    return task;
}
@end
