//
//  YPPMiddlewareTask.m
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//

#import "YPPMiddlewareTask.h"
@interface YPPMiddlewareTask()
@property (nonatomic, copy) void (^excuteBlock)(YPPMiddlewareTask *it);

@end
@implementation YPPMiddlewareTask

+ (instancetype)excute:(void (^)(YPPMiddlewareTask * _Nonnull))excuteBlock {
    YPPMiddlewareTask *task = [[YPPMiddlewareTask alloc] init];
    task.excuteBlock = excuteBlock;
    return task;
}

- (void)setDone:(void (^)(id _Nonnull, BOOL))done {
    _done = [(id)done copy];
    if (self.error && self.excuteBlock) {
        self.excuteBlock(self);
    }
}

- (void)setError:(void (^)(NSError * _Nonnull))error {
    _error = [(id)error copy];
    if (self.done && self.excuteBlock) {
        self.excuteBlock(self);
    }
}

- (void)onDone:(id)data isFinal:(BOOL)isFinal{
    if (self.done) {
        self.done(data, isFinal);
    }
}

- (void)onError:(NSError *)error {
    if (self.error) {
        self.error(error);
    }
}
@end
