//
//  NSString+AES.h
//  PetsProject
//
//  Created by 孟德峰 on 2019/4/15.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)
//加密字符串

- (NSString*)aes128Encrypt:(NSString *)aKey;
//解密字符串
-(NSString*)aes128Decrypt:(NSString *)aKey;
@end

NS_ASSUME_NONNULL_END
