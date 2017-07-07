//
//  DownloadImageTool.h
//  Pictorial-OC
//
//  Created by duodian on 2017/7/5.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WallPaperModel;

@interface DownloadImageTool : NSObject
+ (void)savePaperWithModel:(WallPaperModel *)wallPaperModel;
+ (WallPaperModel *)wallPaperModelFromData:(NSData *)data;
@end
