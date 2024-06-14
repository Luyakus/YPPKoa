//
//  YPPKoaPipe.h
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import <YPPKoa/YPPMiddleware.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YPPPipeStreamProtocol <NSObject>
- (void)sendNext:(id)data;
- (void)sendCompleted;
- (void)sendError:(NSError *)error;
@end

@interface YPPPipeStream : NSObject <YPPPipeStreamProtocol>

- (void)useMiddlware:(YPPMiddleware *)middleware;

- (void)subscribe:(id<YPPPipeStreamProtocol>)subscriber;
- (void)subscribeNext:(void(^)(id x))nextBlock error:(void(^)(NSError *error))errorBlock complete:(void(^)(void))completeBlock;
- (void)subscribeNext:(void(^)(id x))nextBlock error:(void(^)(NSError *error))errorBlock;
- (void)subscribeNext:(void (^)(id x))nextBlock;

@end

NS_ASSUME_NONNULL_END
