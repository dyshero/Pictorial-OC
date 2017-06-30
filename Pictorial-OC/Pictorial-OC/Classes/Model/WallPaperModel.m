//
//  WallPaperModel.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "WallPaperModel.h"

@implementation WallPaperModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
