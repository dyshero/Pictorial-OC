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
#import "ContentDataView.h"
#import "WallPaperController.h"
#import "MyDownloadController.h"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)HomeModel *homeModel;
@property (nonatomic,strong)PictorialView *pictorialView;
@property (nonatomic,strong)SettingView *settingView;
@property (nonatomic,strong)ContentDataView *articleView;
@property (nonatomic,strong)UIToolbar *toolBar;
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
        for (NSInteger i = 0; i < _homeModel.articles.count; i ++) {
            ArticleModel *articleModel = _homeModel.articles[i];
            ContentDataView *articleView = [[[NSBundle mainBundle] loadNibNamed:@"ContentDataView" owner:nil options:nil] lastObject];
            __weak typeof(self) ws = self;
            articleView.alertBlock = ^{
                [ws.view addSubview:ws.toolBar];
                [ws addSettingView];
            };
            articleView.frame = CGRectMake((i + 1)*SWIDTH, 0,SWIDTH, SHEIGHT);
            articleView.model = articleModel;
            [_scrollView addSubview:articleView];
        }
    }
    return _scrollView;
}

- (void)addSettingView{
    [self.view addSubview:self.settingView];
    self.settingView.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.8
                     animations:^{
                         self.settingView.transform =
                         CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              self.settingView.transform = CGAffineTransformIdentity;
                                          }];
                     }];
}

- (PictorialView *)pictorialView{
    if (!_pictorialView) {
        _pictorialView = [[[NSBundle mainBundle] loadNibNamed:@"PictorialView" owner:nil options:nil] lastObject];
        _pictorialView.frame = self.view.bounds;
        [_pictorialView.imageView imageLoadProgressWithNetImage:_homeModel.ios_wallpaper_url];
        __weak typeof(self) ws = self;
        _pictorialView.alertBlock = ^{
            [ws.view addSubview:ws.toolBar];
            [ws addSettingView];
        };
    }
    return _pictorialView;
}

- (ContentDataView *)articleView{
    if (!_articleView) {
        _articleView = [[[NSBundle mainBundle] loadNibNamed:@"ContentDataView" owner:nil options:nil] lastObject];
    }
    return _articleView;
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        _toolBar.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toolTap:)];
        [_toolBar addGestureRecognizer:tap];
    }
    return _toolBar;
}

- (void)toolTap:(UITapGestureRecognizer *)tap {
    [self removeAlertWithComplete:nil];
}

- (void)removeAlertWithComplete:(void(^)())complete {
    [UIView animateWithDuration:0.2
                     animations:^{
                         _settingView.transform =
                         CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              _settingView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                          }
                                          completion:^(BOOL finished) {
                                              [_settingView removeFromSuperview];
                                              _settingView = nil;
                                              [_toolBar removeFromSuperview];
                                              _toolBar = nil;
                                              if (complete) {
                                                  complete();
                                              }
                                          }];
                     }];
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
    if (row == 1) {
        [self removeAlertWithComplete:^{
            WallPaperController *wallPaperVC = [[WallPaperController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:wallPaperVC];
            [self presentViewController:nav animated:YES completion:nil];
        }];
    } else if (row == 2) {
        [self removeAlertWithComplete:^{
            MyDownloadController *downloadVC = [[MyDownloadController alloc] initWithNibName:@"MyDownloadController" bundle:nil];
            [self presentViewController:downloadVC animated:YES completion:nil];
        }];
    }
}

@end
