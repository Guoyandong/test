//
//  BaseTableViewCell.m
//  GQ_****
//
//  Created by Madodg on 2017/11/30.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "BaseTableViewCell.h"
static NSString* iden;
@interface BaseTableViewCell()
@property (nonatomic, strong) UILabel * addLabel;

@property (nonatomic, strong) UILabel * detailLabel;
@end
@implementation BaseTableViewCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    iden = NSStringFromClass([self class]);
    BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[[NSBundle  mainBundle] loadNibNamed:iden owner:self options:nil]  lastObject];
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //让tableview不显示分割线
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)updateCellWithLeftText:(NSString *)left rightText:(NSString *)right imageName:(NSString *)imageName{
    
}


- (void)prepareForMoveSnapshot
{
    // Should be implemented by subclasses if needed
}


- (void)prepareForMove
{
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
    self.imageView.image = nil;
}



@end
