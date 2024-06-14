//
//  YPPSendMessageMiddleware.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPSendMessageMiddleware.h"
#import "YPPChatIMModel.h"
@implementation YPPSendMessageMiddleware

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

@end
