#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveException : NSException

- (instancetype)initWithCode:(int)code;
- (instancetype)initWithMessage:(NSString *)message;
- (int)getCode;
@end

NS_ASSUME_NONNULL_END
