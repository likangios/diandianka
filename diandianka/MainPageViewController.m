//
//  MainPageViewController.m
//  diandianka
//
//  Created by perfay on 2018/11/28.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "MainPageViewController.h"
#import "PicViewController.h"

@interface MainPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UIPageViewController   *pageController;

@end

@implementation MainPageViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            
            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}
- (UIPageViewController *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];;
        _pageController.delegate = self;
        _pageController.doubleSided = YES;
        _pageController.dataSource = self;
        [_pageController setValue:@(NO) forKeyPath:@"_scrollView.bounces"];
    }
    return _pageController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    PicViewController *vc = (PicViewController *)[self getViewControllerWithIndex:0];
    [self.pageController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (UIViewController *)getViewControllerWithIndex:(NSInteger)index{
    if (index >= self.dataArray.count || index < 0) {
        return nil;
    }
    PicModel  *model = self.dataArray[index];
    PicViewController *vc = [[PicViewController alloc]init];
    vc.model = model;
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    PicViewController *vc  =(PicViewController *)viewController;
    NSInteger index = [self.dataArray indexOfObject:vc.model];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self getViewControllerWithIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    PicViewController *vc  =(PicViewController *)viewController;
    NSInteger index = [self.dataArray indexOfObject:vc.model];
    if (index == self.dataArray.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    index++;
    return [self getViewControllerWithIndex:index];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSLog(@"willTransitionToViewControllers");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滑动了:(%.f,%.f)",scrollView.contentOffset.x,scrollView.contentOffset.y);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"停下来了");
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
