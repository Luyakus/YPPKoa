//
//  YPPKoaModelPredicate.m
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//

#import "YPPUITypeModelPredicate.h"
#import "YPPChatIMModel.h"
#import "YPPChatTextCellVM.h"
#import "YPPChatPicCellVM.h"

@implementation YPPUITypeModelPredicate
- (BOOL)canAccept:(id)data {
    return YES;
}

- (id)map:(id)data {
    return data;
}
@end


@implementation YPPUITypeTextPredicate
- (BOOL)canAccept:(YPPChatIMModel *)model {
    NSDictionary *data = model.data;
    if (![data isKindOfClass:NSDictionary.class]) return NO;
    YPPChatMessageUIType messageType = [data[@"type"] integerValue];
    if (messageType != YPPChatMessageUITypeText) return NO;
    return YES;
}

- (id)map:(YPPChatIMModel *)model {
    NSDictionary *data = model.data;
    YPPChatTextCellVM *cvm = [[YPPChatTextCellVM alloc] init];
    cvm.text = [NSString stringWithFormat:@"%@", data[@"text"]];
    return cvm;
}
@end

@implementation YPPUITypePicPredicate
- (BOOL)canAccept:(YPPChatIMModel *)model {
    NSDictionary *data = model.data;
    if (![data isKindOfClass:NSDictionary.class]) return NO;
    YPPChatMessageUIType messageType = [data[@"type"] integerValue];
    if (messageType != YPPChatMessageUITypePic) return NO;
    return YES;
}

- (id)map:(YPPChatIMModel *)model {
    NSDictionary *data = model.data;
    YPPChatPicCellVM *cvm = [[YPPChatPicCellVM alloc] init];
    cvm.picUrl = [NSString stringWithFormat:@"%@", data[@"pic"]];
    return cvm;
}

@end
