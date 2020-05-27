//
//  BaseViewController.m
//  GQ_****
//
//  Created by Madodg on 2017/11/40.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "BaseViewController.h"
//#import "UIViewController+extension.h"
@class ViewController1;
@class UrlWebViewController;

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - TableView 占位图

- (UIImage *)GQ_NoDataViewImage {
    return [UIImage imageNamed:@"play"];
}

- (NSString *)GQ_NoDataViewMessage {
    return @"";
}

- (UIColor *)GQ_NoDataViewMessageColor {
    return [UIColor redColor];
}

- (NSNumber*)GQ_NoDataViewCenterYOffset{
    return [NSNumber numberWithFloat:100.0];
}

- (void)GQ_NoDataViewReloadView{
    NSLog(@"Super reloadView");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    控制导航栏隐藏显示
    if ([self isKindOfClass:NSClassFromString(@"ViewController1")]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    手势返回
    __weak UIViewController *weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)weakSelf;
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    // Do any additional setup after loading the view.
    
}


- (void)setleftBarItem:(NSString*)imageStr;{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAction
{
    [self back];
}

- (void)setleftBarItems:(NSString*)firstImage :(NSString*)secondImage;{
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn addTarget:self action:@selector(leftPress1:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setImage:[UIImage imageNamed:firstImage] forState:UIControlStateNormal];
    
    [firstBtn sizeToFit];
    UIBarButtonItem *firstBtnItem = [[UIBarButtonItem alloc] initWithCustomView:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn addTarget:self action:@selector(leftPress2:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setImage:[UIImage imageNamed:secondImage] forState:UIControlStateNormal];
    
    [secondBtn sizeToFit];
    UIBarButtonItem *secondBtnItem = [[UIBarButtonItem alloc] initWithCustomView:secondBtn];
    
    self.navigationItem.rightBarButtonItems  = @[firstBtnItem,secondBtnItem];
}

-(void)leftPress1:(UIButton*)btn{
    
}

-(void)leftPress2:(UIButton*)btn{
    
}

- (void)setrightBarItem:(NSString*)imageStr;{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(rightPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)rightPress:(UIButton*)btn{
    
}

- (void)setrightBarItems:(NSString*)firstImage :(NSString*)secondImage;{
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn addTarget:self action:@selector(rightPress1:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setImage:[UIImage imageNamed:firstImage] forState:UIControlStateNormal];
    
    [firstBtn sizeToFit];
    UIBarButtonItem *firstBtnItem = [[UIBarButtonItem alloc] initWithCustomView:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn addTarget:self action:@selector(rightPress2:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setImage:[UIImage imageNamed:secondImage] forState:UIControlStateNormal];
    
    [secondBtn sizeToFit];
    UIBarButtonItem *secondBtnItem = [[UIBarButtonItem alloc] initWithCustomView:secondBtn];
    
    self.navigationItem.rightBarButtonItems  = @[firstBtnItem,secondBtnItem];
}

-(void)rightPress1:(UIButton*)btn{
    
}

-(void)rightPress2:(UIButton*)btn{
    
}

- (void)viewSafeAreaInsetsDidChange;{
    [super viewSafeAreaInsetsDidChange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    chackMemory;
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
