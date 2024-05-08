#import <UIKit/UIKit.h>
#import "FaceQuality.h"
#import "CameraConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface MLiveView : UIView

@property (nonatomic, assign)BOOL showFaceLocation;

- (instancetype)initWithFrame:(CGRect)frame config:(CameraConfig *)config;
- (void)faceFound:(FaceQuality *)quality;

@end

NS_ASSUME_NONNULL_END
