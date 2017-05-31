//
//  NSDate+Util.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)
+ (NSString *)today{
    NSDate *today = [NSDate date];
    return [today stringFromDate];
}

+ (NSString *)dateFromDay:(NSInteger)count{
    NSDate *today = [NSDate date];
    NSTimeInterval oneDay = 24 * 60 * 60;
    NSDate *wantDate = [today initWithTimeIntervalSinceNow:-(count * oneDay)];
    return [wantDate stringFromDate];
}

- (NSString *)stringFromDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:self];
    return dateString;
}
@end
