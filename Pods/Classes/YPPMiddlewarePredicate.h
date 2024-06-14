//
//  YPPMiddlewarePredicate.h
//  YPPChatRoomExtension
//
//  Created by DZ0400843 on 2022/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPMiddlewarePredicate : NSObject
- (BOOL)canAccept:(id)data;
- (id)map:(id)data;
@end

NS_ASSUME_NONNULL_END
