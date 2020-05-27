//
//  UITableView+MoveCell.h
//  drawTableViewCell
//
//  Created by yuandiLiao on 2017/5/31.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^moveCellBlock)(NSMutableArray *newArray);
typedef void(^dragEndBlock)(void);

typedef enum{
    SnapshotMeetsEdgeTop = 1,
    SnapshotMeetsEdgeBottom,
}SnapshotMeetsEdge;

@interface UITableView (MoveCell)

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)UIView *snapView;


@property (nonatomic,strong)UITableViewCell *currentCell;
@property (nonatomic,strong)UITableViewCell *exchangeCell;
@property (nonatomic,strong)UITableViewCell *moveCell;

@property (nonatomic,strong)UILongPressGestureRecognizer *longPress;


@property (nonatomic,assign)NSInteger moveIndex;
@property (nonatomic,assign)NSInteger currentIndex;
/**自动滚动的方向*/
@property (nonatomic, assign) SnapshotMeetsEdge autoScrollDirection;
/**cell被拖动到边缘后开启，tableview自动向上或向下滚动*/
@property (nonatomic, strong) CADisplayLink *autoScrollTimer;

@property (nonatomic,weak)moveCellBlock block;
@property (nonatomic,weak)dragEndBlock dragEndBlock;

-(void)setDataWithArray:(NSMutableArray *)array withBlock:(moveCellBlock)block dragEnded:(dragEndBlock)dragEndBlock;
-(void)removeLongPressGesture;

@end
