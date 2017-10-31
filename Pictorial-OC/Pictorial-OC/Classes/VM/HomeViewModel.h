//
//  HomeViewModel.h
//  Pictorial-OC
//
//  Created by duodian on 2017/7/28.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeModel;

@interface HomeViewModel : NSObject
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) RACCommand *requestCommon;
@property (nonatomic,strong) HomeModel *homeModel;
@end
