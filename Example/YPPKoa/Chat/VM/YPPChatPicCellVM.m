//
//  YPPChatMediaCellVM.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPChatPicCellVM.h"
#import "YPPChatPicCell.h"
@implementation YPPChatPicCellVM

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        if ([data isKindOfClass:NSDictionary.class]) {
            self.picUrl = [NSString stringWithFormat:@"%@", data[@"pic"]];
        }
    }
    return self;
}


- (NSString *)cellCls {
    return NSStringFromClass(YPPChatPicCell.class);
}

- (NSInteger)cellHeight {
    return 250;
}
@end
