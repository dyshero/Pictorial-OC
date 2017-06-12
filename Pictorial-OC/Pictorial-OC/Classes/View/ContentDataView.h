//
//  ContentDataView.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleModel;
typedef void(^AlertBlock)();

@interface ContentDataView : UIView
@property (nonatomic,weak)ArticleModel *model;
@property (nonatomic,strong) AlertBlock alertBlock;
@end
