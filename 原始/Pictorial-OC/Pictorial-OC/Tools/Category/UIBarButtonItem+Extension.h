//
//  UIBarButtonItem+Extension.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)barItemWithTitle:(NSString *)title image:(NSString *)image frame:(CGRect)frame target:(id)target sel:(SEL)action;
@end
