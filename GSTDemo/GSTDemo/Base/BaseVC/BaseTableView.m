//
//  BaseTableView.m
//  linkfree
//
//  Created by guoyandong on 2019/12/16.
//  Copyright © 2019 马东东. All rights reserved.
//

#import "BaseTableView.h"
//#import "TransactionModel.h"

@interface BaseTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self initData];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.dataSource = self;
    self.delegate = self;
//    self.backgroundColor = LF_BACKGROUND_COLOR;
}
#pragma mark --> 懒加载
-(NSArray *)leftSlideTitles{
    if (!_leftSlideTitles) {
        _leftSlideTitles = @[NSLocalizedStringFromTable(@"delete", @"ZB", nil)];
    }
    return _leftSlideTitles;
}
-(NSArray<NSString *> *)leftSlideColors{
    if (!_leftSlideColors) {
        _leftSlideColors = @[@"#FF3333"];
    }
    return _leftSlideColors;
}
- (NSMutableArray *)selectArrM{
    if (_selectArrM == nil) {
        _selectArrM = [[NSMutableArray alloc]init];
    }
    return _selectArrM;
}
-(NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (tableView.mj_footer.hidden && [self.models[0] isKindOfClass:[NSArray class]]) {// 是多个section
//        if (section == self.models.count) {
//            //最后一个item
//            return 50.0;
//        }
//    }else{// 是单个section
//        //最后一个item
//        return 50.0;
//    }
    
    return 0.01;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    BOOL isLastFooter = NO;
//    if (self.models.count > 0 && [self.models[0] isKindOfClass:[NSArray class]]) {// 是多个section
//        if (section == self.models.count) {
//            isLastFooter = YES;
//        }
//
//    }else{// 是单个section
//        isLastFooter = YES;
//    }
//    if (tableView.mj_footer.hidden && isLastFooter) {
//        UIView *footer = [UIView new];
//        UILabel *lb = [[UILabel alloc ]initWithFrame:CGRectMake(0, 10, kScreenWidth- 40 , 20)];
//        lb.text = @"----没有更多记录了----";
//        lb.textColor = [UIColor lightGrayColor];
//        lb.textAlignment = NSTextAlignmentCenter;
//        [footer addSubview:lb];
//        return footer;
//    }
//    return nil;
//}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.models.count > 0 && [self.models[0] isKindOfClass:[NSArray class]]) {
        return self.models.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.models.count > 0 && [self.models[0] isKindOfClass:[NSArray class]]) {
        return [self.models[section] count];
    }
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.baseTableViewDataSource respondsToSelector:@selector(baseTableView:cellForRowAtIndexPath:)]) {
        BaseTableViewCell * cell = [self.baseTableViewDataSource baseTableView:self cellForRowAtIndexPath:indexPath];
         return cell;
     }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewCellType == TableViewCellType_Edit && tableView.editing == YES) {
        if (self.allowsMultipleSelectionDuringEditing) {//多选
            [self.selectArrM addObject:self.models[indexPath.row]];
        }else{
//            FileBaseModel * model = (FileBaseModel *)self.models[indexPath.row];
          
            
            [self.selectArrM removeAllObjects];
           
            
            if (self.lastIndexPath != nil) {
                [self.selectArrM removeObject:self.models[self.lastIndexPath.row]];
                BaseTableViewCell * cell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
                cell.selected = NO;
            }
//            if([model.fileOrFolder isEqualToString:@"1"]){//分享文件时，文件夹不可选
//                 BaseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//                 cell.selected = NO;
//            [self makeToast2:NSLocalizedStringFromTable(@"NotOptionalFileFolder", @"ZB", nil) duration:2 position:BOCToastPositionCenter];
//            }else{
//               [self.selectArrM addObject:self.models[indexPath.row]];
//            }
           self.lastIndexPath = indexPath;
        }
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if ([self.baseTableViewDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)]) {
        [self.baseTableViewDelegate baseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewCellType == TableViewCellType_Edit) {
        [self.selectArrM removeObject:self.models[indexPath.row]];
        if (!self.allowsMultipleSelectionDuringEditing && self.lastIndexPath == indexPath) {//单选
            self.lastIndexPath = nil;
        }
    }
    if ([self.baseTableViewDelegate respondsToSelector:@selector(baseTableView:didDeselectRowAtIndexPath:)]) {
           [self.baseTableViewDelegate baseTableView:self didDeselectRowAtIndexPath:indexPath];
       }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据不同状态返回不同编辑模式
    if (self.tableViewCellType == TableViewCellType_Edit) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

//左滑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewCellType == TableViewCellType_LeftSlide || self.tableViewCellType == TableViewCellType_Edit) {
        return YES;
    }
    return NO;
}
//
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self setEditing:false animated:true];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TransactionModel* model =  self.models[indexPath.row];
//    if (![model.userId isEqualToString:[LoginDataManager instance].loginModel.bsUserModel.userId]) {
//        return @[];
//    }
    NSMutableArray * actionArrM = [NSMutableArray array];
    if (self.tableViewCellType != TableViewCellType_LeftSlide) {
        return @[];
    }
    for (int i = 0; i < self.leftSlideTitles.count; i++) {
        //设置删除按钮
        UITableViewRowAction * rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:self.leftSlideTitles[i] handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
            if ([self.baseTableViewDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:atRowActionIndex:)]) {
                [self.baseTableViewDelegate baseTableView:self didSelectRowAtIndexPath:indexPath atRowActionIndex:i];
            }
        }];
//        rowAction.backgroundColor = [UIColor colorWithHexString:self.leftSlideColors[i]];
        [actionArrM addObject:rowAction];
    }
    return actionArrM;
}


// 第0个 section,允许拖动,重排序
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canMove;
//    return YES;
}
@end
