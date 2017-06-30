//
//  MyDownloadController.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/13.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "MyDownloadController.h"

@interface MyDownloadController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
