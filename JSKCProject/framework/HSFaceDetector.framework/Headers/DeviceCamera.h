#import <Foundation/Foundation.h>
#import "AbstractCamera.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceCamera : AbstractCamera

- (instancetype)initWithConfig:(CameraConfig *)config;

@end

NS_ASSUME_NONNULL_END
