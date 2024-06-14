//
//  YPPKoaModelPredicate.h
//  YPPKoa
//
//  Created by DZ0400843 on 2021/8/31.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPUITypeModelPredicate : NSObject
- (BOOL)canAccept:(id)data;
- (id)map:(id)data;
@end

@interface YPPUITypeTextPredicate : YPPUITypeModelPredicate

@end

@interface YPPUITypePicPredicate : YPPUITypeModelPredicate

@end

NS_ASSUME_NONNULL_END
