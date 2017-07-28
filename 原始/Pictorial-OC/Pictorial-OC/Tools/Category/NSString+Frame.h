//
//  NSString+Frame.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Frame)
-(CGFloat)widthWithMaxHeight:(CGFloat)maxHeight attributes:(NSDictionary *)attributes;

-(CGFloat)heightWithMaxWidth:(CGFloat)maxWidth attributes:(NSDictionary *)attributes;
@end
