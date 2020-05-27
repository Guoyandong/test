//
//  BaseTableViewCell.h
//  GQ_****
//
//  Created by Madodg on 2017/11/30.
//  Copyright © 2017年 Madodg. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface BaseTableViewCell : UITableViewCell

- (void)prepareForMoveSnapshot;
- (void)prepareForMove;

/**
 使用时需要强转  需要创建xib的cell使用 cell的id是类名
 cell = [TableViewCell createCellWithTableView:tableView]
 [(TableViewCell*)cell updataCellWithIndex:index];

 @param tableView tableview
 @return 返回对应cell
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView;

- (void)updateCellWithLeftText:(NSString*)left rightText:(NSString*)right imageName:(NSString*)imageName;
@end
