//
//  EnlargePaperView.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WallPaperModel;

@interface EnlargePaperView : UIView
//@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,weak) WallPaperModel *model;
@end
