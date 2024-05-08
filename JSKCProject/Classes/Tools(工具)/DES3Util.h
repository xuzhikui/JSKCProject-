//
//  DES3Util.h
//  PetsProject
//
//  Created by 孟德峰 on 2019/4/15.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DES3Util : NSObject
/**
 * AES128加密，Base64编码输出
 *
 * @param plainText 明文
 * @param secretKey 密钥
 * @param iv 初始向量
 *
 * @return AES128加密后的密文
 */
+ (NSString *)aes128CiphertextFromPlainText:(NSString *)plainText secretKey:(NSString *)secretKey iv:(NSString *)iv;

/**
 * AES128解密，Base64编码输入
 *
 * @param ciphertext 密文
 * @param secretKey 密钥
 * @param iv 初始向量
 *
 * @return AES128解密后的明文
 */
+ (NSString *)aes128PlainTextFromCiphertext:(NSString *)ciphertext secretKey:(NSString *)secretKey iv:(NSString *)iv;
@end

NS_ASSUME_NONNULL_END
