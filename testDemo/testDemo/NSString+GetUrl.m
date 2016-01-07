//
//  NSString+GetUrl.m
//  chibafang_v1.4
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "NSString+GetUrl.h"

@implementation NSString (GetUrl)

+ (NSString *)getImageUrlStr:(NSString *)imageid
{
    return [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m3",imageid];
}

@end
