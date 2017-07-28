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


- (void)showLargeWithPublicModel:(WallPaperModel *)paperModel WithViewController:(UIViewController *)superController {
    EnlargePaperView *enlargeView = [[[NSBundle mainBundle] loadNibNamed:@"EnlargePaperView" owner:nil options:nil] lastObject];
    enlargeView.frame = superController.navigationController.view.bounds;
    enlargeView.model = paperModel;
    [superController.navigationController.view addSubview:enlargeView];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    WallPaperModel *model = _dataArray[indexPath.item];
//    EnlargePaperView *enlargeView = [[[NSBundle mainBundle] loadNibNamed:@"EnlargePaperView" owner:nil options:nil] lastObject];
//    enlargeView.frame = self.navigationController.view.bounds;
//    enlargeView.model = model;
//    [self.navigationController.view addSubview:enlargeView];
}

@end
