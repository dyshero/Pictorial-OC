//
//  UILabel+Extension.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "UILabel+Extension.h"
#import "objc/Runtime.h"

@implementation UILabel (Extension)
- (NSString *)verticalText{
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}
@end
