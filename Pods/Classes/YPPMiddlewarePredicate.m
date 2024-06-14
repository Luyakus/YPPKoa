//
//  YPPMiddlewarePredicate.m
//  YPPChatRoomExtension
//
//  Created by DZ0400843 on 2022/6/15.
//

#import "YPPMiddlewarePredicate.h"

@implementation YPPMiddlewarePredicate
- (BOOL)canAccept:(id)data {
    return NO;
}
- (id)map:(id)data {
    return data;
}
@end
