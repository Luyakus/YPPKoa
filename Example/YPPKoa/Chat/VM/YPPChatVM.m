//
//  YPPChatVM.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPChatVM.h"
#import "YPPChatCellVM.h"
#import "YPPUITypeDispatchMiddleware.h"
#import "YPPSendMessageMiddleware.h"
#import <YPPKoa/YPPPipeStream.h>

@interface YPPChatVM()
@property (nonatomic, strong) YPPPipeStream *sendSteam;
@property (nonatomic, strong) YPPPipeStream *receiveStream;
@property (nonatomic, strong) RACSubject *multiConnection;

@end
@implementation YPPChatVM
- (instancetype)init {
    if (self = [super init]) {
        self.cvms = @[].mutableCopy;
        self.multiConnection = [RACSubject subject];
        self.refreshSignal = [RACSubject subject];
        [self connect];
    }
    return self;
}

- (void)connect {
    self.sendSteam = [[YPPPipeStream alloc] init];
    self.receiveStream = [[YPPPipeStream alloc] init];
    [self.sendSteam subscribe:self.receiveStream];
    
    YPPSendMessageMiddleware *sendMiddleware = [[YPPSendMessageMiddleware alloc] init];
    [self.sendSteam useMiddlware:sendMiddleware];
    
    YPPUITypeDispatchMiddleware *uiMiddleware = [[YPPUITypeDispatchMiddleware alloc] init];
    YPPUITypeTextPredicate *textPredicate = [[YPPUITypeTextPredicate alloc] init];
    YPPUITypePicPredicate *picPredicate = [[YPPUITypePicPredicate alloc] init];
    [uiMiddleware addPredicate:textPredicate];
    [uiMiddleware addPredicate:picPredicate];
    [self.receiveStream useMiddlware:uiMiddleware];
    
    [self.receiveStream subscribeNext:^(YPPChatCellVM *data) {
        if (![data isKindOfClass:YPPChatCellVM.class]) return;
        [self.cvms addObject:data];
        [self.refreshSignal sendNext:nil];
    }];
    
}

- (void)send:(NSDictionary *)data {
    [self.sendSteam sendNext:data];
}

- (void)receive:(YPPChatIMModel *)data {
    [self.receiveStream sendNext:data];
}

@end
