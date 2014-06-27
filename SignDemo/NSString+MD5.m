//
//  NSString+MD5.m
//  SignDemo
//
//  Created by ylang on 14-6-24.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "NSString+MD5.h"

#define Client_Secret_Key @"TefBEz15uB1Tkdoe9BmXhv1mfzqjZerV"

@implementation NSString (MD5)

+ (NSString *) stringWithMD5OfFile: (NSString *) path {
    
	NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath: path];
	if (handle == nil) {
		return nil;
	}
    
	CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
    
	BOOL done = NO;
    
	while (!done) {
        
		NSData *fileData = [[NSData alloc] initWithData: [handle readDataOfLength: 4096]];
		CC_MD5_Update (&md5, [fileData bytes], [fileData length]);
        
		if ([fileData length] == 0) {
			done = YES;
		}
	}
    
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
	NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   digest[0],  digest[1],
				   digest[2],  digest[3],
				   digest[4],  digest[5],
				   digest[6],  digest[7],
				   digest[8],  digest[9],
				   digest[10], digest[11],
				   digest[12], digest[13],
				   digest[14], digest[15]];
    
	return s;
    
}

- (NSString *) MD5Hash {
    
	CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
	CC_MD5_Update (&md5, [self UTF8String], [self length]);
    
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
	NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   digest[0],  digest[1],
				   digest[2],  digest[3],
				   digest[4],  digest[5],
				   digest[6],  digest[7],
				   digest[8],  digest[9],
				   digest[10], digest[11],
				   digest[12], digest[13],
				   digest[14], digest[15]];
    
	return s;
}

@end


@implementation SignString

#pragma mark - 排序 组合成  k1=v1k2=v2k3=v3
+ (NSString *)mergeParamsDict:(NSDictionary *)parmsDict
{
    NSString *mergedParamsStr = [NSString stringWithFormat:@""];
    NSArray *AllKeys = [NSArray arrayWithArray:[parmsDict allKeys]];
    NSArray *sortedKeys = [AllKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    
    for (NSString * key in sortedKeys)
    {
        NSString *value = [NSString stringWithFormat:@"%@", [parmsDict objectForKey:key]];
        mergedParamsStr = [mergedParamsStr stringByAppendingFormat:@"%@=%@", key, value];
    }
    NSLog(@"=====%@",[NSString stringWithFormat:@"%@%@",mergedParamsStr,Client_Secret_Key]);
    return [NSString stringWithFormat:@"%@%@",mergedParamsStr,Client_Secret_Key];
}
+ (NSString *)mergeParams:(NSDictionary *)parmsDict
{
    NSString *mergedParamsStr = [NSString stringWithFormat:@""];
    NSArray *AllKeys = [NSArray arrayWithArray:[parmsDict allKeys]];
//    NSArray *sortedKeys = [AllKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2];
//    }];
//    for (NSString * key in AllKeys)
//    {
//        NSString *value = [NSString stringWithFormat:@"%@", [parmsDict objectForKey:key]];
//        mergedParamsStr = [mergedParamsStr stringByAppendingFormat:@"%@=%@&", key, value];
//    }
    for (int i= 0; i < [AllKeys count]; i++)
    {
        NSString *value = [NSString stringWithFormat:@"%@", [parmsDict objectForKey:[AllKeys objectAtIndex:i]]];
        if (i == ([AllKeys count] -1))
        {
            mergedParamsStr = [mergedParamsStr stringByAppendingFormat:@"%@=%@",[AllKeys objectAtIndex:i], value];
        }else
        {
            mergedParamsStr = [mergedParamsStr stringByAppendingFormat:@"%@=%@&",[AllKeys objectAtIndex:i], value];
        }
        
    }

    return mergedParamsStr;
}

+ (NSString *)requestDic:(NSMutableDictionary *)dic
{

    NSString *signDic = [[self mergeParamsDict:dic] MD5Hash];
    
//    [dic setObject:signDic forKey:@"sig"];
    
//    NSString *request = [self mergeParams:dic];
    return signDic;
//    return request;
}
@end
