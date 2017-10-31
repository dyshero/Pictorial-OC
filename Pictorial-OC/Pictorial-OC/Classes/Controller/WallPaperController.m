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
#import "DownloadImageTool.h"
#import "WallPaperViewModel.h"

@interface WallPaperController ()<UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong)  WallPaperViewModel *requesViewModel;
@end

@implementation WallPaperController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"壁纸集";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithTitle:nil image:@"close" frame:CGRectMake(0, 0, 30, 30) target:self sel:@selector(close)];
    [self.view addSubview:self.collectionView];
    self.requesViewModel.collectionView = self.collectionView;
    [self.requesViewModel.reuqesCommand execute:nil];
}

- (WallPaperViewModel *)requesViewModel {
    if (!_requesViewModel) {
        _requesViewModel = [[WallPaperViewModel alloc] init];
    }
    return _requesViewModel;
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.itemSize = CGSizeMake((SWIDTH - 15)/2, ((SWIDTH - 15)/2)*568/320);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self.requesViewModel;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WallPaperCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperModel *model = self.requesViewModel.models[indexPath.item];
    WallPaperCell *cell = (WallPaperCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *defaultImageView = [cell.contentView viewWithTag:1];
    [self.requesViewModel showLargeWithPublicModel:model WithViewController:self defaultImageView:defaultImageView];
}
@end
