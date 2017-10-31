//
//  HomeViewModel.m
//  Pictorial-OC
//
//  Created by duodian on 2017/7/28.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "HomeViewModel.h"
#import "NSDate+Util.h"
#import "HomeModel.h"
#import "ArticleModel.h"
#import "ContentDataView.h"

@implementation HomeViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self initBind];
    }
    return self;
}

- (void)initBind {
    _requestCommon = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSString *dateURL = [NSString stringWithFormat:@"http://chanyouji.com/api/pictorials/%@.json",[NSDate dateFromDay:1]];
            [AFNet getRequestHttpURL:dateURL completation:^(id object) {
                [subscriber sendNext:object];
            } failure:^(NSError *error) {
                
            }];
            return nil;
        }];
        
        return [signal map:^id(NSDictionary *value) {
            HomeModel *homeModel = (HomeModel *)[value.rac_sequence map:^id(id value) {
                return [HomeModel modelWithDict:value];
            }];
            NSArray *articleArray = value[@"articles"];
            NSArray *modelArray = [[articleArray.rac_sequence map:^id(id value) {
                return [ArticleModel modelWithDict:value];
            }] array];
            homeModel.articles = modelArray;
            return homeModel;
        }];
    }];
    
    [_requestCommon.executionSignals.switchToLatest subscribeNext:^(HomeModel *x) {
        _homeModel = x;
        
        _scrollView.contentSize = CGSizeMake(SWIDTH * (_homeModel.articles.count+1), 0);
//        [_scrollView addSubview:self.pictorialView];
        for (NSInteger i = 0; i < _homeModel.articles.count; i ++) {
            ArticleModel *articleModel = _homeModel.articles[i];
            ContentDataView *articleView = [[[NSBundle mainBundle] loadNibNamed:@"ContentDataView" owner:nil options:nil] lastObject];
            __weak typeof(self) ws = self;
            articleView.alertBlock = ^{
//                [ws.view addSubview:ws.toolBar];
//                [ws addSettingView];
            };
            articleView.frame = CGRectMake((i + 1)*SWIDTH, 0,SWIDTH, SHEIGHT);
            articleView.model = articleModel;
            [_scrollView addSubview:articleView];
        }
    }];
}
@end
