//
//  YPPChatTextCellVM.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPChatTextCellVM.h"
#import "YPPChatTextCell.h"
@implementation YPPChatTextCellVM
- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        if ([data isKindOfClass:NSDictionary.class]) {
            self.text = [NSString stringWithFormat:@"%@", data[@"text"]];
        }
    }
    return self;
}

- (NSString *)cellCls {
    return NSStringFromClass(YPPChatTextCell.class);
}

- (NSInteger)cellHeight {
    return UITableViewAutomaticDimension;
}
@end
