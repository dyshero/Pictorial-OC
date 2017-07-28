//
//  DownloadImageTool.m
//  Pictorial-OC
//
//  Created by duodian on 2017/7/5.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "DownloadImageTool.h"
#import "WallPaperModel.h"

@implementation DownloadImageTool

+ (void)saveDownWithArray:(NSArray *)array {
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:DOWNLOAD_DATA];
}

+ (void)savePaperWithModel:(WallPaperModel *)wallPaperModel {
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:DOWNLOAD_DATA]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wallPaperModel];
    [array addObject:data];
    [self saveDownWithArray:array];
}

+ (WallPaperModel *)wallPaperModelFromData:(NSData *)data {
    WallPaperModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}
@end

