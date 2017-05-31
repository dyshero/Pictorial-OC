//
//  SettingView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "SettingView.h"
#import "SettingCell.h"

@interface SettingView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_pictures;
    NSArray *_titles;
}
@end

@implementation SettingView

- (instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, SWIDTH * 0.6, SWIDTH*0.7-20);
        _pictures = @[@"pictorial.png",@"wallpaper.png",@"my_download.png",@"clear.png"];
        _titles = @[@"画报集",@"壁纸集",@"我的下载",@"清除缓存"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.title = _titles[indexPath.row];
    cell.picture = _pictures[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SWIDTH*0.7-20)/4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellClickBlock) {
        self.cellClickBlock(indexPath.row);
    }
}
@end
