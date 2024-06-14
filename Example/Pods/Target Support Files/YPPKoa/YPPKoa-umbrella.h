#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "YPPMiddleware.h"
#import "YPPMiddlewarePredicate.h"
#import "YPPMiddlewareTask.h"
#import "YPPPipeStream.h"

FOUNDATION_EXPORT double YPPKoaVersionNumber;
FOUNDATION_EXPORT const unsigned char YPPKoaVersionString[];

