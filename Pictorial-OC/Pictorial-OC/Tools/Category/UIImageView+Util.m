//
//  UIImageView+Util.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/30.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "UIImageView+Util.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Util)
- (void)imageLoadProgressWithNetImage:(NSString *)imageUrl {
    dispatch_queue_t queue = dispatch_queue_create("thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImage *plachoderImage = [UIImage imageNamed:@"placholder_date.png"];
        
        
        __block UIProgressView *progressView;
        [self sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:plachoderImage options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [progressView removeFromSuperview];
                progressView = nil;
                if (progressView == nil) {
                    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                    [self addSubview:progressView];
                    progressView.frame = CGRectMake(0, 0, self.frame.size.width * 0.5, 5);
                    [progressView setTransform:CGAffineTransformScale(progressView.transform, 1.0, 2.0)];
                    progressView.center = self.center;
                    progressView.backgroundColor = [UIColor whiteColor];
                    progressView.progressTintColor = COLOR_THEME;
                    progressView.trackTintColor = [UIColor whiteColor];
                }
                float progress = (float)receivedSize / (float)expectedSize;
                progressView.progress = progress;
            });
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.image = image;
            [progressView removeFromSuperview];
            progressView = nil;
        }];
    });
}

/**
 *  压缩图片后加载到imageView上
 *
 *  @param image 图片
 */
-(void)imageAfterCondenseWithURL:(UIImage *)image{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *newdata = UIImageJPEGRepresentation(image, 0.5);
        UIImage *newImage = [UIImage imageWithData:newdata];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.image = newImage;
            
        });
        
    });
    
}

@end
