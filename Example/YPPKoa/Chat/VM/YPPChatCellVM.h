//
//  YPPChatCellVM.h
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPChatCellVM : NSObject
@property (nonatomic, copy) NSString *cellCls;
@property (nonatomic, assign) NSInteger cellHeight;

- (instancetype)initWithData:(id)data;
@end

NS_ASSUME_NONNULL_END
