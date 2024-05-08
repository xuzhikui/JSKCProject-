#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CameraConfig : NSObject

@property(nonatomic, assign)AVCaptureDevicePosition position;
// AVCaptureSessionPreset352x288, AVCaptureSessionPreset640x480,
// AVCaptureSessionPreset1280x720, AVCaptureSessionPreset1920x1080
@property(nonatomic, copy)AVCaptureSessionPreset sessionPreset;

@end

NS_ASSUME_NONNULL_END
