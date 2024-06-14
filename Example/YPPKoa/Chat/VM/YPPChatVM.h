//
//  YPPChatVM.h
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "YPPChatCellVM.h"
#import "YPPChatIMModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YPPChatVM : NSObject
@property (nonatomic, strong) RACSubject *refreshSignal;
@property (nonatomic, strong) NSMutableArray <YPPChatCellVM *> *cvms;
- (void)receive:(YPPChatIMModel *)data;
- (void)send:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
