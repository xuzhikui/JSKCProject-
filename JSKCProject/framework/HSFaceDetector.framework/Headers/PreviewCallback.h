#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol PreviewCallback <NSObject>

- (void)onPreviewFrame:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
