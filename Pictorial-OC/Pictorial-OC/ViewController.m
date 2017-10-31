//
//  ViewController.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // develop测试
    [AFNet getRequestHttpURL:@"http://chanyouji.com/api/pictorials.json" completation:^(id object) {
        NSLog(@"%@",object);
        
        [AFNet getRequestHttpURL:@"" completation:^(id object) {
            
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
