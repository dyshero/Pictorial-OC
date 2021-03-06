//
//  UILabel+Extension.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
@property (nonatomic) NSString *verticalText;
+(UILabel *)labelWithText:(NSString *)string fontSize:(CGFloat)fontSize frame:(CGRect)frame color:(UIColor *)color textAlignment:(int)textAlignment;
@end
