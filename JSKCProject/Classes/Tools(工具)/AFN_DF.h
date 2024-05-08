//
//  AFN_DF.h
//  YbtPrject
//
//  Created by aaa on 2018/6/23.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface AFN_DF : NSObject

/** get方法 */
+ (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;

/** post方法 */
+ (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;

/** post方法上传图片 */
+ (void)POST:(NSString *)url Parameters:(NSMutableDictionary *)parameters File:(NSArray *)file ImageArr:(NSArray *)imageArr ContVC:(UIViewController *)vc success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;
///获取当前控制器

+ (UIViewController *)topViewController;
+ (UIViewController *)_topViewController:(UIViewController *)vc;
//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;
///md5加密
+(NSString *)MD5ForLower32Bate:(NSString *)str;
+(NSString *)Base64Lower:(NSString *)str;
+ (NSString *) sha1:(NSString *)input;
///获取机型
+ (BOOL )getDeviceModel;

///sign签名
+(NSString *)signDict:(NSMutableDictionary *)parameters;

@end
