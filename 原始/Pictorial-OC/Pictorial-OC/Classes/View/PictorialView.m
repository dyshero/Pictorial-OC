//
//  PictorialView.m
//  Pictorial-OC
//
//  Created by duodian on 2017/5/31.
//  Copyright © 2017年 duodian. All rights reserved.
//

#import "PictorialView.h"

@implementation PictorialView

- (IBAction)alertClicked:(id)sender {
    if (self.alertBlock) {
        self.alertBlock();
    }
}

@end
