//
//  HOMETopData.m
//  chibafang_v1.4
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "HOMETopData.h"

@implementation HOMETopData

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"uri"]) {
        _url = value;
    }
}

@end
