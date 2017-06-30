//
//  UIBarButtonItem+Extension.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)barItemWithTitle:(NSString *)title image:(NSString *)image frame:(CGRect)frame target:(id)target sel:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (image) {
        [btn setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
