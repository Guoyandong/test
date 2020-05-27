//
//  BaseViewController.h
//  GQ_****
//
//  Created by Madodg on 2017/11/30.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong) UIImageView* barImageView;

@property (nonatomic,assign) NSInteger     pageNum; //页码
@property (nonatomic,assign) NSInteger     pageSize;//每页显示条数
@property (nonatomic,assign) NSInteger     totalPage;//总页码数
@property (nonatomic,assign) NSInteger     totalCount; //总数据条数
@property (nonatomic,assign) NSInteger     currentPage; //当前页数

- (void)setleftBarItem:(NSString*)imageStr;
- (void)setleftBarItems:(NSString*)firstImage :(NSString*)secondImage;

- (void)setrightBarItem:(NSString*)imageStr;
- (void)setrightBarItems:(NSString*)firstImage :(NSString*)secondImage;

- (void)backAction;

@end
