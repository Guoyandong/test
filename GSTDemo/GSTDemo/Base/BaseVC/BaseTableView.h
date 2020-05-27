//
//  BaseTableView.h
//  linkfree
//
//  Created by guoyandong on 2019/12/16.
//  Copyright © 2019 马东东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
//#import "FileBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BaseTableView;
@protocol BaseTableViewDelegate <NSObject, UITableViewDelegate>
@optional

- (void)baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath atRowActionIndex:(NSInteger)rowActionIndex;
- (void)baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)baseTableView:(BaseTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)moveTableView:(BaseTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
- (void)moveTableView:(BaseTableView *)tableView willMoveRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@protocol BaseTableViewDataSource <NSObject, UITableViewDataSource>

@required
- (BaseTableViewCell *)baseTableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
//- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section;
//- (void)moveTableView:(BaseTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
//- (BOOL)moveTableView:(BaseTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger,TableViewCellType) {
    TableViewCellType_Default = 0, //默认正常
    TableViewCellType_LeftSlide,   //左滑
    TableViewCellType_Edit,        //勾选编辑
};

@interface BaseTableView : UITableView<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *models;
///>左滑时显示按钮的文字, 默认只有删除
@property (nonatomic, strong) NSArray <NSString *>*leftSlideTitles;
///>左滑时显示按钮的颜色, 默认只有红色
@property (nonatomic, strong) NSArray <NSString *>*leftSlideColors;
@property (nonatomic, assign) TableViewCellType tableViewCellType;

@property (nonatomic, weak) id <BaseTableViewDelegate> baseTableViewDelegate;
@property (nonatomic, weak) id <BaseTableViewDataSource> baseTableViewDataSource;
@property (nonatomic, strong) NSMutableArray * selectArrM;//存储选中的数据
@property (nonatomic, strong, nullable) NSIndexPath *lastIndexPath;

#pragma mark - Long Press Move
//@property (nonatomic, strong, nullable) NSIndexPath *movingIndexPath;
//@property (nonatomic, strong, nullable) NSIndexPath *initialIndexPathForMovingRow;


@property (nonatomic, assign) BOOL canMove;//是否可以拖动


//- (BOOL)indexPathIsMovingIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)adaptedIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
