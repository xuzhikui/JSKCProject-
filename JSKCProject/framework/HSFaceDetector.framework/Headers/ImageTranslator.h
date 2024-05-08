#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ImageTranslator : NSObject

+ (UIImage *)imageTransform:(UIImage *)image rotation:(int)angle;

+ (UIImage *)getRGBAImage:(UIImage *)BGRAImage;

+ (unsigned char *)decodeImageFromRGBA:(UIImage *)RGBAImage;

+ (unsigned char *)decodeImageFromBGRA:(UIImage *)BGRAImage;

+ (UIImage *)encodeImageWithRgb:(unsigned char *)data width:(int)width height:(int)height;

@end

NS_ASSUME_NONNULL_END
