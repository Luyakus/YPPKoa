//
//  YPPKoaPipe.m
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import "YPPPipeStream.h"
@protocol YPPPipeStreamDisposeProtocol
- (void)dispose;
@end


@interface YPPPipeStream()
@property (nonatomic, strong) NSMutableArray *middlewares;
@property (nonatomic, strong) NSMutableArray <id <YPPPipeStreamDisposeProtocol>> *disposeBag;

@property (nonatomic, copy) void(^nextBlock)(id);
@property (nonatomic, copy) void(^errorBlock)(NSError *);
@property (nonatomic, copy) void(^completeBlock)(void);
@end


@implementation YPPPipeStream

- (instancetype)init {
    if (self = [super init]) {
        self.middlewares = @[].mutableCopy;
        self.disposeBag = @[].mutableCopy;
    }
    return self;
}

- (void)useMiddlware:(YPPMiddleware *)middleware {
    [self.middlewares addObject:middleware];
}

- (void)subscribe:(id<YPPPipeStreamProtocol>)subscriber {
    [self subscribeNext:^(id  _Nonnull x) {
        [subscriber sendNext:x];
    } error:^(NSError * _Nonnull error) {
        [subscriber sendError:error];
    } complete:^{
        [subscriber sendCompleted];
    }];
}

- (void)subscribeNext:(void(^)(id x))nextBlock error:(void(^)(NSError *error))errorBlock complete:(void(^)(void))completeBlock {
    self.nextBlock = nextBlock;
    self.errorBlock = errorBlock;
    self.completeBlock = completeBlock;
}
- (void)subscribeNext:(void(^)(id x))nextBlock error:(void(^)(NSError *error))errorBlock {
    [self subscribeNext:nextBlock error:errorBlock complete:^{}];
}

- (void)subscribeNext:(void (^)(id x))nextBlock {
    [self subscribeNext:nextBlock error:^(NSError *error){} complete:^{}];
}

- (void)sendNext:(id)data {
    NSArray *array = self.middlewares.copy;
    [self processData:data middlewares:array error:nil];
}

- (void)sendError:(NSError *)error {
    if (self.errorBlock) {
        self.errorBlock(error);
    }
}

- (void)sendCompleted {
    if (self.completeBlock) {
        self.completeBlock();
    }
    [self.disposeBag enumerateObjectsUsingBlock:^(id<YPPPipeStreamDisposeProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj dispose];
    }];
}

- (void)processData:(id)data middlewares:(NSArray <YPPMiddleware *> *)middlewares error:(NSError *)error {
    if (middlewares.count == 0) {
        if (error) {
            [self sendError:error];
        }
        if (data) {
            if (self.nextBlock) {
                self.nextBlock(data);
            };
        }
    }
    YPPMiddleware *middle = middlewares.firstObject;
    YPPMiddlewareTask *task = [middle use:data];
    task.error = ^(NSError *error) {
        [self processData:data middlewares:@[] error:error];
    };
    task.done = ^(id mapData, BOOL isFinal) {
        if (middlewares.count == 1 || isFinal) {
            [self processData:mapData middlewares:@[] error:nil];
        } else {
            NSArray *sub = [middlewares subarrayWithRange:NSMakeRange(1, middlewares.count - 1)].copy;
            [self processData:mapData middlewares:sub error:nil];
        }
    };
}

- (void)didSubscribeWithDisposable:(id)disposable {
    if ([disposable respondsToSelector:@selector(dispose)]) {
        [self.disposeBag addObject:disposable];
    }
}

@end
