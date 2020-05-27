//
//  UITableView+MoveCell.m
//  drawTableViewCell
//
//  Created by yuandiLiao on 2017/5/31.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

#import "UITableView+MoveCell.h"
#import <objc/runtime.h>

@implementation UITableView (MoveCell)


//绑定数据源和添加手势
-(void)setDataWithArray:(NSMutableArray *)array withBlock:(moveCellBlock)block dragEnded:(dragEndBlock)dragEndBlock{
    self.dataArray = [[NSMutableArray alloc] init];
    [self.dataArray addObjectsFromArray:array];
    self.block = block;
    self.dragEndBlock = dragEndBlock;
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:self.longPress];
}
-(void)removeLongPressGesture{
    [self removeGestureRecognizer:self.longPress];
}
-(BOOL)canDragableIndexpath:(NSIndexPath *)indexPath{
    return [self.dataSource tableView:self canMoveRowAtIndexPath:indexPath];
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{
            self.indexPath = nil;
//            [self reloadData];
            CGPoint point = [longPress locationOfTouch:0 inView:longPress.view];
//            self.indexPath = [self indexPathForRowAtPoint:point];
            
            // 0417_wxk_可移动的 indexPath 才赋值保存后续处理
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            if([self canDragableIndexpath:indexPath]){
                self.indexPath = indexPath;
            }
            // 0417_wxk_---------
            
            //indexpath可能为空
            if (self.indexPath) {
//                NSLog(@"%s---section:%lu---row:%lu", __func__, self.indexPath.section, self.indexPath.row);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.moveCell = [self cellForRowAtIndexPath:self.indexPath];
                    self.currentCell = [self cellForRowAtIndexPath:self.indexPath];
                    self.currentIndex = self.indexPath.row;
                    self.snapView = [self.moveCell snapshotViewAfterScreenUpdates:NO];
                    self.snapView.frame = self.moveCell.frame;
                    [self addSubview:self.snapView];
                    self.moveCell.hidden = YES;
                    [UIView animateWithDuration:0.1 animations:^{
                        self.snapView.transform = CGAffineTransformScale(self.snapView.transform, 1.03, 1.05);
                        self.snapView.alpha = 0.8;
                    }];

                });
                
            }
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [longPress locationOfTouch:0 inView:longPress.view];
            CGPoint center  = self.snapView.center;
            center.y = point.y;
            self.snapView.center = center;
//            if ([self checkIfSnapshotMeetsEdge]) {
//                [self startAutoScrollTimer];
//            }else{
//                [self stopAutoScrollTimer];
//            }
            
//            NSIndexPath *exchangeIndex = [self indexPathForRowAtPoint:point];
            
             // 0417_wxk_可移动的 indexPath 才赋值保存后续处理
            NSIndexPath *exchangeIndex = nil;
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            if([self canDragableIndexpath:indexPath]){
                exchangeIndex = indexPath;
            }
            // 0417_wxk_---------
            
//            NSLog(@"%s---section:%lu---row:%lu", __func__, exchangeIndex.section, exchangeIndex.row);
            
            //exchangeIndex可能为空
            if (exchangeIndex && self.indexPath.row != exchangeIndex.row) {
                self.moveIndex = exchangeIndex.row;
                [self updateDataWithIndexPath:exchangeIndex];
                self.exchangeCell = [self cellForRowAtIndexPath:exchangeIndex];
                [self moveRowAtIndexPath:self.indexPath toIndexPath:exchangeIndex];
                self.indexPath = exchangeIndex;
                
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.moveCell  = [self cellForRowAtIndexPath:self.indexPath];
                [UIView animateWithDuration:0.2 animations:^{
                    self.snapView.center = self.moveCell.center;
                    self.snapView.transform = CGAffineTransformIdentity;
                    self.snapView.alpha = 1.0;
                } completion:^(BOOL finished) {
                    self.moveCell.hidden = NO;
                    [self.snapView removeFromSuperview];
//                    [self stopAutoScrollTimer];
                    if (self.dataArray.count > 1) {
                        if (self.dragEndBlock) {
                            self.dragEndBlock();
                        }
                    }
                }];

            });
        }
            break;
        default:
            break;
    }
}


/**
 *  检查截图是否到达边缘，并作出响应
 */
- (BOOL)checkIfSnapshotMeetsEdge{
    CGFloat minY = CGRectGetMinY(self.snapView.frame);
    CGFloat maxY = CGRectGetMaxY(self.snapView.frame);
    if (minY < self.contentOffset.y) {
        self.autoScrollDirection = SnapshotMeetsEdgeTop;
        return YES;
    }
    if (maxY > self.bounds.size.height + self.contentOffset.y) {
        self.autoScrollDirection = SnapshotMeetsEdgeBottom;
        return YES;
    }
    return NO;
}

# pragma mark - timer methods
/**
 *  创建定时器并运行
 */
- (void)startAutoScrollTimer{
    if (self.autoScrollTimer == nil) {
        self.autoScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAutoScroll)];
        [self.autoScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}
/**
 *  停止定时器并销毁
 */
- (void)stopAutoScrollTimer{
    if (self.autoScrollTimer) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
}
/**
 *  开始自动滚动
 */
- (void)startAutoScroll{
    CGFloat pixelSpeed = 4;
    if (self.autoScrollDirection == SnapshotMeetsEdgeTop) {//向上滚动
        if (self.contentOffset.y > 0) {//向下滚动最大范围限制
            [self setContentOffset:CGPointMake(0, self.contentOffset.y - pixelSpeed)];
            self.snapView.center = CGPointMake(self.snapView.center.x, self.snapView.center.y - pixelSpeed);
        }
    }else{                                               //向下滚动
        if (self.contentOffset.y + self.bounds.size.height < self.contentSize.height) {//向下滚动最大范围限制
            [self setContentOffset:CGPointMake(0, self.contentOffset.y + pixelSpeed)];
            self.snapView.center = CGPointMake(self.snapView.center.x, self.snapView.center.y + pixelSpeed);
        }
    }
    
    /* 
    交换cell
     */
//    NSIndexPath *exchangePath= [self indexPathForRowAtPoint:self.snapView.center];
    
    // 0417_wxk_可移动的 indexPath 才赋值保存后续处理
    NSIndexPath *exchangePath = nil;
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:self.snapView.center];
    if([self canDragableIndexpath:indexPath]){
        exchangePath = indexPath;
    }
    // 0417_wxk_---------
    
    if (exchangePath) {
        [self updateDataWithIndexPath:exchangePath];
        [self moveRowAtIndexPath:self.indexPath toIndexPath:exchangePath];
        self.indexPath = exchangePath;
    }
 
    
}

//更新数据源
-(void)updateDataWithIndexPath:(NSIndexPath *)moveIndexPath
{
    //判断是否是嵌套数组
    if ([self nestedArrayCheck:self.dataArray]) {
        if (self.indexPath.section == moveIndexPath.section) {
            NSMutableArray *originalArray = self.dataArray[self.indexPath.section];

            [originalArray exchangeObjectAtIndex:self.indexPath.row withObjectAtIndex:moveIndexPath.row];

        }else{
            NSMutableArray *originalArray = self.dataArray[self.indexPath.section];
            NSMutableArray *removeArray = self.dataArray[moveIndexPath.section];
            NSString * obj = [originalArray objectAtIndex:self.indexPath.row];
            [removeArray insertObject:obj atIndex:moveIndexPath.row];
            [originalArray removeObjectAtIndex:self.indexPath.row];
        }
      
    }else{
        NSLog(@"self.indexPath.row == %ld  moveIndexPath.row == %ld",self.indexPath.row,moveIndexPath.row);
        [self.dataArray exchangeObjectAtIndex:self.indexPath.row withObjectAtIndex:moveIndexPath.row];
    }
    
    self.block(self.dataArray);

}

- (BOOL)nestedArrayCheck:(NSArray *)array{
    for (id obj in array) {
        if ([obj isKindOfClass:[NSArray class]]) {
            return YES;
        }
    }
    return NO;
}

-(NSMutableArray *)dataArray
{
    return objc_getAssociatedObject(self, "dataArray");

}

-(void)setDataArray:(NSMutableArray *)dataArray{
    objc_setAssociatedObject(self, "dataArray", dataArray,OBJC_ASSOCIATION_RETAIN);
}

-(moveCellBlock)block
{
    return objc_getAssociatedObject(self, "block");

}
-(void)setBlock:(moveCellBlock)block
{
    objc_setAssociatedObject(self, "block", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(dragEndBlock)dragEndBlock{
    return objc_getAssociatedObject(self, "dragEndBlock");
}
-(void)setDragEndBlock:(dragEndBlock)dragEndBlock{
    objc_setAssociatedObject(self, "dragEndBlock", dragEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(UIView *)snapView
{
    return objc_getAssociatedObject(self, "snapView");
}
-(void)setSnapView:(UIView *)snapView
{
    objc_setAssociatedObject(self, "snapView", snapView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, "indexPath");
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, "indexPath", indexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(CADisplayLink *)autoScrollTimer
{
    return objc_getAssociatedObject(self, "autoScrollTimer");
}

-(void)setAutoScrollTimer:(CADisplayLink *)autoScrollTimer
{
    objc_setAssociatedObject(self, "autoScrollTimer", autoScrollTimer, OBJC_ASSOCIATION_RETAIN);
}
-(UITableViewCell *)moveCell
{
    return objc_getAssociatedObject(self, "moveCell");
}
-(void)setMoveCell:(UITableViewCell *)moveCell
{
    objc_setAssociatedObject(self, "moveCell", moveCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITableViewCell *)currentCell
{
    return objc_getAssociatedObject(self, "currentCell");
}
-(void)setCurrentCell:(UITableViewCell *)currentCell
{
    objc_setAssociatedObject(self, "currentCell", currentCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(UITableViewCell *)exchangeCell
{
    return objc_getAssociatedObject(self, "exchangeCell");
}
-(void)setExchangeCell:(UITableViewCell *)exchangeCell
{
    objc_setAssociatedObject(self, "exchangeCell", exchangeCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}



-(SnapshotMeetsEdge)autoScrollDirection
{

    return (SnapshotMeetsEdge)[objc_getAssociatedObject(self, "autoScrollDirection") integerValue];

}
-(void)setAutoScrollDirection:(SnapshotMeetsEdge)autoScrollDirection
{
    objc_setAssociatedObject(self, "autoScrollDirection", @(autoScrollDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(NSInteger)moveIndex
{
    return [objc_getAssociatedObject(self, "moveIndex") integerValue];
}
-(void)setMoveIndex:(NSInteger)moveIndex
{
    objc_setAssociatedObject(self, "moveIndex", @(moveIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)currentIndex{
    return [objc_getAssociatedObject(self, "currentIndex") integerValue];
}
-(void)setCurrentIndex:(NSInteger)currentIndex{
    objc_setAssociatedObject(self, "currentIndex", @(currentIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UITableViewCell *)longPress
{
    return objc_getAssociatedObject(self, "longPress");
}
-(void)setLongPress:(UILongPressGestureRecognizer *)longPress
{
    objc_setAssociatedObject(self, "longPress", longPress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
@end
