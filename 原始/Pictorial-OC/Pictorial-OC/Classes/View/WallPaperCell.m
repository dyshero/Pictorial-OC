//
//  WallPaperCell.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "WallPaperCell.h"
#import "WallPaperModel.h"

@interface WallPaperCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@end

@implementation WallPaperCell

- (void)setModel:(WallPaperModel *)model{
    [_imageView imageLoadProgressWithNetImage:model.ios_wallpaper_url];
    NSArray *dateArray = [model.publish_date componentsSeparatedByString:@"-"];
    _dayLabel.text = dateArray[2];
    _monthLabel.text = [self monthWithNum:dateArray[1]];
}

- (NSString *)monthWithNum:(NSString *)number {
    NSArray *numArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    NSArray *dateArray = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    NSInteger index = [numArray indexOfObject:number];
    return dateArray[index];
}

@end
