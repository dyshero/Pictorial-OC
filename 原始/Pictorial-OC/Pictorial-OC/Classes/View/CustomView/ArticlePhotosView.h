//
//  ArticlePhotosView.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageTapBlock)(UITapGestureRecognizer *tap);

@interface ArticlePhotosView : UIView
- (void)setImageWithArray:(NSArray *)images;
@property (nonatomic,strong) ImageTapBlock imageTapBlock;
@end
