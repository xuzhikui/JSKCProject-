#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LiveDetectControllerDelegate <NSObject>

- (void)onFailed:(int)code withMessage:(NSString *)message;
- (void)onFinishWithSign:(NSString *)imageSign;

@end

@interface LiveDetectController : UIViewController

@property (nonatomic, weak)id<LiveDetectControllerDelegate> delegate;
@property (nonatomic, copy)NSString *license;
@property (nonatomic, strong)NSArray *actionList;
@property (nonatomic, assign)int actionTimeout;
@property (nonatomic, assign)BOOL isCameraBack;
@property (nonatomic, assign)BOOL openSound;
@property (nonatomic, assign)int minFaceSize;
@property (nonatomic, assign)int maxFaceSize;
@property (nonatomic, assign)BOOL checkMaskWear;
@property (nonatomic, assign)BOOL checkOcclusion;
@property (nonatomic, assign)BOOL closeMouthQuality;
@property (nonatomic, assign)float screenBright;
@end

NS_ASSUME_NONNULL_END
