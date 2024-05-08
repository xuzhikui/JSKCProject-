#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveConfig : NSObject

/**
 * 最小人脸, 默认 60
 */
@property (nonatomic, assign)int minFaceSize;
/**
 * 最大人脸, 默认 180
 */
@property (nonatomic, assign)int maxFaceSize;
/**
 * 人脸距离图像边缘像素 left
 */
@property (nonatomic, assign)int leftPadding;
/**
 * 人脸距离图像边缘像素 right
 */
@property (nonatomic, assign)int rightPadding;
/**
 * 人脸距离图像边缘像素 top
 */
@property (nonatomic, assign)int topPadding;
/**
 * 人脸距离图像边缘像素 bottom
 */
@property (nonatomic, assign)int bottomPadding;
/**
 * 是否需要口罩检测, 默认不检测
 */
@property (nonatomic, assign)BOOL checkMaskWear;
/**
 * 是否需要遮挡检测, 默认不检测
 */
@property (nonatomic, assign)BOOL checkOcclusion;
/**
 * 是否要把闭嘴作为图像质量的判定标准, 默认不检测
 */
@property (nonatomic, assign)BOOL checkMouthClose;

@end

NS_ASSUME_NONNULL_END
