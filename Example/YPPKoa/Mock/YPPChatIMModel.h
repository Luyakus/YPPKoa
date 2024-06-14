//
//  LGChatIMModel.h
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YPPChatIMModelType) {
    YPPChatIMModelTypeChat,
    YPPChatIMModelTypeCmd,
};


typedef NS_ENUM(NSUInteger, YPPChatMessageUIType) {
    YPPChatMessageUITypeText,
    YPPChatMessageUITypePic,
    YPPChatMessageUITypeVideo
};



NS_ASSUME_NONNULL_BEGIN

@interface YPPChatIMModel : NSObject
@property (nonatomic, assign) YPPChatIMModelType imType;
@property (nonatomic, strong) NSDictionary *data;
@end



NS_ASSUME_NONNULL_END
