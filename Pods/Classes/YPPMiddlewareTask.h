//
//  YPPMiddlewareTask.h
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPMiddlewareTask : NSObject
@property (nonatomic, copy) void(^done)(id data, BOOL isFinal);
@property (nonatomic, copy) void(^error)(NSError *error);

- (void)onDone:(id)data isFinal:(BOOL)isFinal;
- (void)onError:(NSError *)error;

+ (instancetype)excute:(void(^)(YPPMiddlewareTask *it))excuteBlock;
@end

NS_ASSUME_NONNULL_END
