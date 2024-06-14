### iOS 里的中间件系统

NodeJS 中鼎鼎大名的 Koa 框架, 以其巧妙的设计, 强大的扩展能力, 深受开发人员的喜爱,
这个库借鉴了 Koa 中最精华的中间件系统, 并与 ReactiveCocoa 融合, 可以使您响应式的
处理数据.

使用场景包括但不限于: 文本编辑器, 文件处理, 消息处理, 音视频流处理. 发挥想象力, 只有想
不到, 没有做不到.

#### 场景举例

假设正开发一个 IM 界面, 发送的消息要上屏, 接受的消息也要上屏, 我们希望发送和接受走同一个
渲染逻辑, 可以构建两个中间件系统: sendStream 和 receiveStream. sendStream 负责把
输入的信息转换为传输载体, receiveStream 负责把传输载体转为上屏的 renderModel. 同时
把 sendStream 和 receiveStream 连接起来, 使其可以使用同一套上屏逻辑, 代码如下

```objc
- (void)connect {
    // 创建 sendStream
    self.sendSteam = [[YPPPipeStream alloc] init];
    // 创建 receiveStream
    self.receiveStream = [[YPPPipeStream alloc] init];
    // 连接
    [self.sendSteam subscribe:self.receiveStream];

    // 创建发送中间件
    YPPSendMessageMiddleware *sendMiddleware = [[YPPSendMessageMiddleware alloc] init];
    // 把中间件添加到数据处理流程
    [self.sendSteam useMiddlware:sendMiddleware];

    // 创建解析UI中间件
    YPPUITypeDispatchMiddleware *uiMiddleware = [[YPPUITypeDispatchMiddleware alloc] init];
    // 创建解析文本消息组件
    YPPUITypeTextPredicate *textPredicate = [[YPPUITypeTextPredicate alloc] init];
    // 创建解析图片消息组件
    YPPUITypePicPredicate *picPredicate = [[YPPUITypePicPredicate alloc] init];
    // 添加到中间件中
    [uiMiddleware addPredicate:textPredicate];
    // 添加到中间件中
    [uiMiddleware addPredicate:picPredicate];
    // 把中间件添加到数据处理流程
    [self.receiveStream useMiddlware:uiMiddleware];
    // 这时候吐出的数据就是可以直接上屏的 renderModel
    [self.receiveStream subscribeNext:^(YPPChatCellVM *data) {
        if (![data isKindOfClass:YPPChatCellVM.class]) return;
        [self.cvms addObject:data];
        [self.refreshSignal sendNext:nil];
    }];

}
```

YPPSendMessageMiddleware, 代码如下:

```objc
- (YPPMiddlewareTask *)use:(id)data {
    return [YPPMiddlewareTask excute:^(YPPMiddlewareTask * _Nonnull it) {
        if (![data isKindOfClass:NSDictionary.class]) {
            [it onDone:data isFinal:NO]; // 不处理直接透传
        }
        YPPChatIMModel *imModel = [[YPPChatIMModel alloc] init];
        imModel.imType = YPPChatIMModelTypeChat;
        imModel.data = data;
        [it onDone:imModel isFinal:NO];
    }];
}
```

可以看到, 中间件的核心是返回一个类似 Promise 的 task, 因此, 我们不但可以在中间件里处理同步任务
也可以在中间件里处理异步数据

YPPUITypeDispatchMiddleware

```objc
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
```

这是接受消息流程的中间件, 在这个中间件里可以插入子组件, 是一种非常灵活的扩充功能的方式, 通过子组件判断能不能解析
该数据, 如果可以, 则交给子组件处理

接下来我们看 YPPPipeStream

```objc
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
```

YPPPipeStream, 可以添加多个中间件, 既实现了 subscriber 的协议, 又实现了 signal 的相关方法, 所以既可以当做发送方也可以当做接收方,
这样做既可以把多个业务模块的处理逻辑连接起来, 又可以很好的与 ReactiveCocoa 配合, 是不是已经想到无数种场景可以实践了 :)
