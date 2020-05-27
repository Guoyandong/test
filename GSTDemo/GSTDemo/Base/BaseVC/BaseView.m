//
//  BaseView.m
//  linkfree
//
//  Created by guoyandong on 2019/12/21.
//  Copyright © 2019 马东东. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
+ (instancetype)createViewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
