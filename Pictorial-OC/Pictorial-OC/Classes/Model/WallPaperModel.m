//
//  WallPaperModel.m
//  Pictorial-OC
//
//  Created by duodian on 2017/6/12.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "WallPaperModel.h"

@implementation WallPaperModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.ios_wallpaper_url forKey:@"ios_wallpaper_url"];
    [aCoder encodeObject:self.destination forKey:@"destination"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.ios_wallpaper_url = [aDecoder decodeObjectForKey:@"ios_wallpaper_url"];
        self.destination = [aDecoder decodeObjectForKey:@"destination"];
    }
    return self;
}

@end
