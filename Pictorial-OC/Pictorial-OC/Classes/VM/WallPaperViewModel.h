//
//  WallPaperViewModel.h
//  Pictorial-OC
//
//  Created by duodian on 2017/7/28.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WallPaperModel;

@interface WallPaperViewModel : NSObject <UICollectionViewDataSource>
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;
@property (nonatomic, strong, readonly) NSArray *models;
@property (nonatomic, weak) UICollectionView *collectionView;
- (void)showLargeWithPublicModel: (WallPaperModel *)paperModel WithViewController: (UIViewController *)superController defaultImageView:(UIImageView *)defaultImageView;
@end
