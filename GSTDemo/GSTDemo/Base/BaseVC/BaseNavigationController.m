//
//  BaseNavigationController.m
//  GQ_****
//
//  Created by Madodg on 2017/11/30.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    //去掉UINavigationBar的阴影
    
    [navBar setShadowImage:[[UIImage alloc] init]];
    
//    [navBar setBarTintColor:UICOLOR_RGB_Alpha(0x3296FA, 1)];
    
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:18]
                                     }];
//    [barItem setTitleTextAttributes:@{
//                                      NSForegroundColorAttributeName : [UIColor yellowColor],
//                                      NSFontAttributeName : [UIFont systemFontOfSize:15]
//                                      } forState:UIControlStateNormal];
//    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // push过程中隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
// 修改tabBra的frame 防止iphoneX pushVC底部上移
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}
-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
     if (self.childViewControllers.count > 0) {
         UIViewController * viewController = viewControllers.lastObject;
            // push过程中隐藏tabBar
            viewController.hidesBottomBarWhenPushed = YES;
        }
        [super setViewControllers:viewControllers animated:animated];
        // 修改tabBra的frame 防止iphoneX pushVC底部上移
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.presentingViewController && self.viewControllers.count == 1) {
        [super dismissViewControllerAnimated:animated completion:nil];
    } else {
        [super popViewControllerAnimated:animated];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
