//
//  ContentDataView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "ContentDataView.h"
#import <UIImageView+WebCache.h>
#import "ArticleModel.h"
#import "ArticlePhotosView.h"
#import "AmplifyView.h"

@interface ContentDataView ()

@property (weak, nonatomic) IBOutlet UILabel *titLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *photo_authorLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *text_authorLabel;
@property (weak, nonatomic) IBOutlet ArticlePhotosView *photosView;
@end

@implementation ContentDataView

- (void)setModel:(ArticleModel *)model{
    [_imageView setImageWithURL:[NSURL URLWithString:model.image_url] placeholder:nil options:YYWebImageOptionRefreshImageCache completion:nil];
    _titLabel.text = model.title;
    _descLabel.text = model.desc;
    _photo_authorLabel.text = model.photo_author;
    _text_authorLabel.text = model.text_author;
    NSInteger count = model.photos.count;
    CGFloat height = (SWIDTH-30)/2;
    if (count % 2 == 0) {
        _photosHeightConstraint.constant = (count/2)*height + (count/2-1)*10;
    }else{
        _photosHeightConstraint.constant = (count/2+1)*height + (count/2)*10;
    }
    
    [_photosView setImageWithArray:model.photos];
    
    _photosView.imageTapBlock = ^(UITapGestureRecognizer *tap) {
        [self imageTapWithTap:tap];
    };
}

- (void)imageTapWithTap:(UITapGestureRecognizer *)tap {
    AmplifyView *amplifyView = [[AmplifyView alloc] initWithFrame:[UIScreen mainScreen].bounds andGesture:tap andSuperView:self];
    [[UIApplication sharedApplication].keyWindow addSubview:amplifyView];
}

- (IBAction)alertClicked:(id)sender {
    if (self.alertBlock) {
        self.alertBlock();
    }
}

@end
