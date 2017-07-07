//
//  MyDownloadController.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "MyDownloadController.h"
#import "WallPaperModel.h"
#import "DownloadImageTool.h"
#import <UIImageView+WebCache.h>

@interface MyDownloadController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation MyDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SWIDTH - 40 - 45)/2, 200);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.collectionViewLayout = layout;
    
    NSArray *downloadArray = [[NSUserDefaults standardUserDefaults] objectForKey:DOWNLOAD_DATA];
    _dataArray = [NSMutableArray array];
    for (NSData *data in downloadArray) {
        WallPaperModel *model = [DownloadImageTool wallPaperModelFromData:data];
        [_dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperModel *model = _dataArray[indexPath.item];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.ios_wallpaper_url]];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
