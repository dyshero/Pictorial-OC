//
//  SettingCell.m
//  Pictorial
//
//  Created by SKY on 15/12/29.
//  Copyright © 2015年 sky. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SettingCell

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)setPicture:(NSString *)picture{
    self.pictureView.image = [UIImage imageNamed:picture];
}

@end
