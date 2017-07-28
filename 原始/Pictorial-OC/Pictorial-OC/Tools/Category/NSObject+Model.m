//
//  NSObject+Model.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)
+ (id)modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
