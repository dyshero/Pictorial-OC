//
//  EnlargePaperView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "EnlargePaperView.h"
#import <UIImageView+WebCache.h>
#import "WallPaperModel.h"
#import "NSString+Frame.h"
#import <SVProgressHUD.h>

@interface EnlargePaperView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@end

@implementation EnlargePaperView

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMe)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    _titLabel.hidden = YES;
    _descLabel.hidden = YES;
    _viewHeightConstraint.constant = 0;
}

- (void)removeMe {
    [self removeFromSuperview];
}

- (void)setModel:(WallPaperModel *)model{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.ios_wallpaper_url]];
    _titLabel.text = model.destination;
    _descLabel.text = model.title;
}

- (IBAction)showClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [UIView animateWithDuration:0.5 animations:^{
            _titLabel.hidden = NO;
            _descLabel.hidden = NO;
            [btn setTransform:CGAffineTransformMakeRotation(M_PI_2 / 90 * 135)];
            CGFloat titleHeight = [_model.destination heightWithMaxWidth:15.5 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            CGFloat descHeight = [_model.title heightWithMaxWidth:15.5 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            if (titleHeight >= descHeight) {
                _viewHeightConstraint.constant = titleHeight + 15;
            }else {
                _viewHeightConstraint.constant = descHeight + 15;
            }
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [btn setTransform:CGAffineTransformMakeRotation(0)];
            _viewHeightConstraint.constant = 0;
            _titLabel.hidden = YES;
            _descLabel.hidden = YES;
        }];
    }
}

- (IBAction)downloadClicked:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.ios_wallpaper_url]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImageWriteToSavedPhotosAlbum(photo, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        });
    });
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSString *documentPath = [self getDocumentPath];
        NSString *arrayFilePath = [documentPath stringByAppendingPathComponent:@"downloads.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:arrayFilePath]) {
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:arrayFilePath];
        }
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }else {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}

- (NSString *)getDocumentPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents[0];
    return documentPath;
}

@end
