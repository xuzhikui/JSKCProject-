#import <Foundation/Foundation.h>
#import "Livedefined.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActionConfig : NSObject

/**
 * 动作类型
 */
@property (nonatomic, assign)Action action;
/**
 * 动作检测超时时间, 默认 8000 ms
 */
@property (nonatomic, assign)int actionTimeout;
/**
 * 开始动作检测前的准备时间, 默认 1000 ms
 */
@property (nonatomic, assign)int prepareInterval;

@end

NS_ASSUME_NONNULL_END
