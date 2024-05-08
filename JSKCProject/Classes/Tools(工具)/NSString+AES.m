//
//  NSString+AES.m
//  PetsProject
//
//  Created by 孟德峰 on 2019/4/15.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import "NSString+AES.h"

#define gIv             @"0102030405060708" //自行修改16位 -->偏移量

@implementation NSString (AES)

- (NSString *)aes128Encrypt:(NSString *)aKey

{
    
    char keyPtr[kCCKeySizeAES128+1];
    
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [aKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    
    int newSize = 0;
    
    
    
    if(diff > 0)
        
    {
        
        newSize = dataLength + diff;
        
    }
    
    
    
    char dataPtr[newSize];
    
    memcpy(dataPtr, [data bytes], [data length]);
    
    for(int i = 0; i < diff; i++)
        
    {
        
        dataPtr[i + dataLength] = 0x00;
        
    }
    
    
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    memset(buffer, 0, bufferSize);
    
    
    
    size_t numBytesCrypted = 0;
    
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          
                                          kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding,  // 补码方式
                                          
                                          keyPtr,
                                          
                                          kCCKeySizeAES128,
                                          
                                          ivPtr,
                                          
                                          dataPtr,
                                          
                                          sizeof(dataPtr),
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &numBytesCrypted);
    
    
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *result = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        if (result && result.length > 0) {
            
            
            
            Byte *datas = (Byte*)[result bytes];
            
            NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
            
            for(int i = 0; i < result.length; i++){
                
                [output appendFormat:@"%02x", datas[i]];
                
            }
            
            return output;
            
        }
        
    }
    
    free(buffer);
    
    return nil;
    
}



- (NSString *)aes128Decrypt:(NSString *)aKey

{
    
    char keyPtr[kCCKeySizeAES128 + 1];
    
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [aKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    
    unsigned char whole_byte;
    
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    
    for (i=0; i < [self length] / 2; i++) {
        
        byte_chars[0] = [self characterAtIndex:i*2];
        
        byte_chars[1] = [self characterAtIndex:i*2+1];
        
        whole_byte = strtol(byte_chars, NULL, 16);
        
        [data appendBytes:&whole_byte length:1];
        
    }
    
    
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          
                                          kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          keyPtr,
                                          
                                          kCCBlockSizeAES128,
                                          
                                          ivPtr,
                                          
                                          [data bytes],
                                          
                                          dataLength,
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
    }
    
    free(buffer);
    
    return nil;
    
}

@end
