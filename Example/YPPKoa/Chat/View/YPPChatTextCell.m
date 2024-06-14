//
//  YPPChatTextCell.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPChatTextCell.h"
#import "YPPChatTextCellVM.h"
#import <Masonry.h>
@interface YPPChatTextCell()
@property (nonatomic, strong) UILabel *titleLab;

@end
@implementation YPPChatTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab = [UILabel new];
        self.titleLab.font = [UIFont systemFontOfSize:18];
        self.titleLab.textColor = UIColor.blackColor;
        self.titleLab.numberOfLines = 0;
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.right.equalTo(self.contentView).offset(-90);
        }];
    }
    return self;
}

- (void)bind:(YPPChatTextCellVM *)cvm {
    if (![cvm isKindOfClass:YPPChatTextCellVM.class]) return;
    self.titleLab.text = cvm.text;
}

@end
