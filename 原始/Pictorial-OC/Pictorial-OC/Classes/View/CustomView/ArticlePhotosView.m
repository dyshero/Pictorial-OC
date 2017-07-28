//
//  ArticlePhotosView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "ArticlePhotosView.h"
#import <UIImageView+WebCache.h>

@implementation ArticlePhotosView
- (void)setImageWithArray:(NSArray *)images{
    CGFloat width = (SWIDTH - 20 - 10)/2;
    CGFloat height = width;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0;i < images.count; i ++) {
        NSDictionary *dict = images[i];
        NSString *path = dict[@"image_url"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:path]];
        if (i % 2 == 0) {
            x = 0;
        }else{
            x = width + 10;
        }
        
        NSInteger row = i/2;
        y = (10 + height) * row;
        imageView.frame = CGRectMake(x, y, width, height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
}

- (void)imageTap:(UITapGestureRecognizer *)tap {
    if (self.imageTapBlock) {
        self.imageTapBlock(tap);
    }
}

@end
