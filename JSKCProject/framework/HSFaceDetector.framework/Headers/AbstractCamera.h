#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PreviewCallback.h"
#import "CameraConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface AbstractCamera : NSObject

@property (nonatomic, strong)CameraConfig *config;

- (AVCaptureVideoPreviewLayer *)getPreviewLayer;
- (void)setPreviewCallback:(id<PreviewCallback>)callback;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
