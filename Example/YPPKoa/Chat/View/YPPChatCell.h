//
//  YPPChatCell.h
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPPChatCellVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface YPPChatCell : UITableViewCell
- (void)bind:(YPPChatCellVM *)cvm;
@end

NS_ASSUME_NONNULL_END
