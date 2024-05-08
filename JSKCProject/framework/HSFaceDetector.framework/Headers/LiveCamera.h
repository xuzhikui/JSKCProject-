#import <Foundation/Foundation.h>
#import "MLiveView.h"
#import "CameraConfig.h"
#import "ActionConfig.h"
#import "LiveConfig.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LiveCallback <NSObject>

// 实时更新检测信息
- (void)update:(FaceQuality *)quality status:(LiveStatus)status;
// 开始检测动作
- (void)beginAction:(Action)action;
// 结束动作检测
- (void)endAction:(Action)action status:(ActionStatus)status;

@end

@interface LiveCamera : NSObject
+ (NSString *)getVersion;
+ (NSString *)getSDKInfo;
+ (NSString *)getExpireDate:(NSString *)license;
- (instancetype)initWithLicense:(NSString *)license config:(CameraConfig *)config;
- (MLiveView *)getPreview:(CGRect)previewRect;
- (void)setLiveConfig:(LiveConfig *)config;
- (void)startLive:(NSArray<ActionConfig *> *)actionConfigs callback:(id<LiveCallback>)callback;
- (void)stopLive;
- (void)destroy;

@end

NS_ASSUME_NONNULL_END
