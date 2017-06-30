//
//  WallPaperController.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "WallPaperController.h"
#import "WallPaperCell.h"
#import "AFNet.h"
#import "WallPaperModel.h"
#import "UIBarButtonItem+Extension.h"
#import "EnlargePaperView.h"

@interface WallPaperController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation WallPaperController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"壁纸集";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithTitle:nil image:@"close" frame:CGRectMake(0, 0, 30, 30) target:self sel:@selector(close)];
    [self.view addSubview:self.collectionView];
    _dataArray = [NSMutableArray array];
    [AFNet getRequestHttpURL:@"http://chanyouji.com/api/pictorials.json" completation:^(id object) {
        for (NSDictionary *dic in object) {
            WallPaperModel *model = [WallPaperModel modelWithDict:dic];
            [_dataArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.itemSize = CGSizeMake((SWIDTH - 15)/2, ((SWIDTH - 15)/2)*568/320);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WallPaperCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperModel *model = _dataArray[indexPath.item];
    EnlargePaperView *enlargeView = [[[NSBundle mainBundle] loadNibNamed:@"EnlargePaperView" owner:nil options:nil] lastObject];
    enlargeView.frame = self.navigationController.view.bounds;
    enlargeView.model = model;
    [self.navigationController.view addSubview:enlargeView];
}
@end
