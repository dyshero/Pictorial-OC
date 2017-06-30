//
//  WallPaperModel.h
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WallPaperModel : NSObject
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *destination;
@property (nonatomic,copy)NSString *android_wallpaper_url;
@property (nonatomic,copy)NSString *ios_wallpaper_url;
@property (nonatomic,copy)NSString *publish_date;
@property (nonatomic,copy)NSString *title;
@end
