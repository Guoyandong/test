//
//  WorkViewController.m
//  GSTDemo
//
//  Created by 郭严东 on 2020/5/27.
//  Copyright © 2020 guoyandong. All rights reserved.
//

#import "WorkViewController.h"
#import "WorkCollectionCell.h"

@interface WorkViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout * flowLayout;
@end

@implementation WorkViewController


#pragma mark - =======  initSubViews  =======
-(void)initSubViews{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WorkCollectionCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([WorkCollectionCell class])];
    
//    [self addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_equalTo(kCollectionViewCellHeight);
//    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initSubViews];
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
