//
//  PictorialView.h
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertBlock)();

@interface PictorialView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)AlertBlock alertBlock;
@end
