//
//  HomeModel.h
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (nonatomic,copy) NSString *destination;
@property (nonatomic,copy) NSString *android_wallpaper_url;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *ios_wallpaper_url;
@property (nonatomic,copy) NSString *publish_date;
@property (nonatomic,copy) NSArray *articles;
@end
