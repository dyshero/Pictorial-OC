//
//  ArticleModel.h
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *image_url;
@property (nonatomic,copy)NSString *summary;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *photo_author;
@property (nonatomic,copy)NSString *text_author;
@property (nonatomic,copy)NSString *destination_intro_title;
@property (nonatomic,copy)NSString *destination_intro;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,strong)NSArray *description_notes;
@property (nonatomic,strong)NSArray *photos;
@property (nonatomic,strong)NSDictionary *attraction;
@property (nonatomic,strong)NSDictionary *trip;
@property (nonatomic,strong)NSDictionary *destination;
@end
