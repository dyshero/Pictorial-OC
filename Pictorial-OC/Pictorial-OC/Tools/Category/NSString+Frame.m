//
//  NSString+Frame.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "NSString+Frame.h"

@implementation NSString (Frame)
-(CGFloat)widthWithMaxHeight:(CGFloat)maxHeight attributes:(NSDictionary *)attributes{
    CGRect frame = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return frame.size.width;
}

-(CGFloat)heightWithMaxWidth:(CGFloat)maxWidth attributes:(NSDictionary *)attributes{
    CGRect frame = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return frame.size.height;
}

@end
