//
//  YPPChatPicCell.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "YPPChatPicCell.h"
#import "YPPChatPicCellVM.h"
#import <Masonry.h>
#import <SDWebImage.h>
@interface YPPChatPicCell()
@property (nonatomic, strong) UIImageView *picView;
@end

@implementation YPPChatPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.picView = [[UIImageView alloc] init];
        self.picView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.picView];
        [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(100);
        }];
    }
    return self;
}


- (void)bind:(YPPChatPicCellVM *)cvm {
    if (![cvm isKindOfClass:YPPChatPicCellVM.class]) return;
    [self.picView sd_setHighlightedImageWithURL:[NSURL URLWithString:cvm.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        [self.picView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(self.picView.mas_height).multipliedBy(image.size.width/image.size.height);
        }];
        self.picView.image = image;
    }];
}
@end
