//
//  PicViewController.h
//  yezjk
//
//  Created by perfay on 2018/6/19.
//  Copyright © 2018年 luck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicViewController : UIViewController

@property(nonatomic,strong) PicModel *model;

@property(nonatomic,copy) void (^showHiddenNavbarBlocks)(void);

- (void)speakMehtod;
@end
