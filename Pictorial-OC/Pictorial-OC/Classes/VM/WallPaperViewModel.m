//
//  WallPaperViewModel.m
//  Pictorial-OC
//
//  Created by duodian on 2017/7/28.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "WallPaperViewModel.h"
#import "WallPaperCell.h"
#import "WallPaperModel.h"
#import "EnlargePaperView.h"
#import <Masonry.h>

@interface WallPaperViewModel ()
@property (nonatomic,assign) CGRect defaultFrame;
@property (nonatomic,strong) UIView *enlargeView;
@end


@implementation WallPaperViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initBind];
    }
    return self;
}

- (void)initBind {
    _reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [AFNet getRequestHttpURL:@"http://chanyouji.com/api/pictorials.json" completation:^(id object) {
                [subscriber sendNext:object];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                
            }];
            return nil;
        }];
        
        return [requestSiganl map:^id(NSArray* value) {
            NSArray *modelArray = [[value.rac_sequence map:^id(id value) {
                return [WallPaperModel modelWithDict:value];
            }] array];
            return modelArray;
        }];
    }];
    
    [_reuqesCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        _models = x;
        [self.collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _models[indexPath.item];
    return cell;
}

- (void)showLargeWithPublicModel:(WallPaperModel *)paperModel WithViewController:(UIViewController *)superController defaultImageView:(UIImageView *)defaultImageView {
    UIView *enlargeView = [[UIView alloc] init];
    enlargeView.userInteractionEnabled = YES;
    enlargeView.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = defaultImageView.image;
    [enlargeView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.leading.mas_equalTo(enlargeView);
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect defaultFrame = [defaultImageView convertRect:defaultImageView.frame toView:window];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer *sender) {
            [UIView animateWithDuration:0.5 animations:^{
                enlargeView.frame = defaultFrame;
            } completion:^(BOOL finished) {
                [sender.view removeFromSuperview];
            }];
    }];
    [enlargeView addGestureRecognizer:tap];
    enlargeView.frame = defaultFrame;
    [window addSubview:enlargeView];
    [UIView animateWithDuration:0.5 animations:^{
        enlargeView.frame = window.bounds;
    } completion:^(BOOL finished) {
        
    }];
}


@end
