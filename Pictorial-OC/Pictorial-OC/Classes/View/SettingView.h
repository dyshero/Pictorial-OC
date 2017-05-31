//
//  SettingView.h
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellClickBlock)(NSInteger row);

@interface SettingView : UITableView
@property (nonatomic,strong) CellClickBlock cellClickBlock;
@end
