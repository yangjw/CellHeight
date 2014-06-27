//
//  NSString+MD5.h
//  SignDemo
//
//  Created by ylang on 14-6-24.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

// MD5 hash of the file on the filesystem specified by path
+ (NSString *) stringWithMD5OfFile: (NSString *) path;
// The string's MD5 hash
- (NSString *) MD5Hash;


@end


@interface SignString : NSObject
{

}

#pragma mark - 排序 组合成  k1=v1k2=v2k3=v3
+ (NSString *)mergeParamsDict:(NSDictionary *)parmsDict;
#pragma mark - 排序 组合成  k1=v1&k2=v2&k3=v3
+ (NSString *)mergeParams:(NSDictionary *)parmsDict;
+ (NSString *)requestDic:(NSMutableDictionary *)dic;
@end