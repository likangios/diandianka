//
//  ViewController.m
//  diandianka
//
//  Created by perfay on 2018/11/19.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "ViewController.h"
#import "MainPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    MainPageViewController *page = [[MainPageViewController alloc]init];
    [self.navigationController pushViewController:page animated:YES];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
