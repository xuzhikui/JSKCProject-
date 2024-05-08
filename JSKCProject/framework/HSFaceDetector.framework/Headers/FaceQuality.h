#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Livedefined.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceQuality : NSObject

/**
 * 检测到的人脸数量
 */
@property (nonatomic, assign)int faceNum;
/**
 * 实时的人脸检测状态
 */
@property (nonatomic, assign)HSFaceType faceType;
/**
 * 最大人脸在图像中的坐标 x
 */
@property (nonatomic, assign)float x;
/**
 * 最大人脸在图像中的坐标 y
 */
@property (nonatomic, assign)float y;
/**
 * 最大人脸在图像中像素宽
 */
@property (nonatomic, assign)float width;
/**
 * 最大人脸在图像中像素高
 */
@property (nonatomic, assign)float height;
/**
 * 人脸图像
 */
@property (nonatomic, strong)UIImage *faceImage;

/**
 * 经过签名加密后的图片
 */
@property (nonatomic, copy)NSString *signImage;

@end

NS_ASSUME_NONNULL_END
