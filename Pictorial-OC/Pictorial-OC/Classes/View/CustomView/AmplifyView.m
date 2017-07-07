//
//  AmplifyView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/7/5.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "AmplifyView.h"

@interface AmplifyView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *lastImageView;
@property (nonatomic,assign) CGRect originalFrame;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation AmplifyView

- (instancetype)initWithFrame:(CGRect)frame andGesture:(UITapGestureRecognizer *)tap andSuperView:(UIView *)superView{
    if (self = [super initWithFrame:frame]) {
        //scrollView作为背景
        UIScrollView *bgView = [[UIScrollView alloc] init];
        bgView.frame = [UIScreen mainScreen].bounds;
        bgView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
        [bgView addGestureRecognizer:tapBg];
        
        UIImageView *picView = (UIImageView *)tap.view;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = picView.image;
        imageView.frame = [bgView convertRect:picView.frame fromView:self];
        [bgView addSubview:imageView];
        [self addSubview:bgView];
        
        self.lastImageView = imageView;
        self.originalFrame = imageView.frame;
        self.scrollView = bgView;
        
        //最大放大比例
        self.scrollView.maximumZoomScale = 1.5;
        self.scrollView.delegate = self;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = imageView.frame;
            frame.size.width = bgView.frame.size.width;
            frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
            frame.origin.x = 0;
            frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
            imageView.frame = frame;
        }];
    }
    return self;
}

-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer {
    self.scrollView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.5 animations:^{
        self.lastImageView.frame = self.originalFrame;
        tapBgRecognizer.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [tapBgRecognizer.view removeFromSuperview];
        [self removeFromSuperview];
        self.scrollView = nil;
        self.lastImageView = nil;
    }];
}

//返回可缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.lastImageView;
}

@end
