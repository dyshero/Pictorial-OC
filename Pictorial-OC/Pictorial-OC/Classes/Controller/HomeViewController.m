//
//  HomeViewController.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "ArticleModel.h"
#import "NSDate+Util.h"
#import "PictorialView.h"
#import "SettingView.h"
#import <UIImageView+WebCache.h>

@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)HomeModel *homeModel;
@property (nonatomic,strong)PictorialView *pictorialView;
@property (nonatomic,strong)SettingView *settingView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataWithPage:0];
}

- (void)loadDataWithPage:(NSInteger)page{
    NSString *dateURL = [NSString stringWithFormat:@"http://chanyouji.com/api/pictorials/%@.json",[NSDate dateFromDay:page]];
    [AFNet getRequestHttpURL:dateURL completation:^(id object) {
        _homeModel = [HomeModel modelWithDict:object];
        NSMutableArray *articles = [NSMutableArray array];
        for (NSDictionary *articleDict in object[@"articles"]) {
            ArticleModel *articleModel = [ArticleModel modelWithDict:articleDict];
            [articles addObject:articleModel];
        }
        _homeModel.articles = articles;
        [self makeUI];
    } failure:^(NSError *error) {
        
    }];
}

- (void)makeUI{
    [self.view addSubview:self.scrollView];
}

#pragma -mark 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SWIDTH * (_homeModel.articles.count+1), 0);
        [_scrollView addSubview:self.pictorialView];
    }
    return _scrollView;
}

- (PictorialView *)pictorialView{
    if (!_pictorialView) {
        _pictorialView = [[[NSBundle mainBundle] loadNibNamed:@"PictorialView" owner:nil options:nil] lastObject];
        _pictorialView.frame = self.view.bounds;
        [_pictorialView.imageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.ios_wallpaper_url]];
        __weak typeof(self) ws = self;
        _pictorialView.alertBlock = ^{
            [ws.view addSubview:ws.settingView];
        };
    }
    return _pictorialView;
}

- (SettingView *)settingView{
    if (!_settingView) {
        _settingView = [SettingView new];
        _settingView.center = self.view.center;
        __weak typeof(self) ws = self;
        _settingView.cellClickBlock = ^(NSInteger row) {
            [ws cellClicked:row];
        };
    }
    return _settingView;
}

-  (void)cellClicked:(NSInteger)row{
    
}

@end
