//
//  myModle.h
//  GQ_****
//
//  Created by Madodg on 2017/12/5.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface myModle : BaseModel
@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* phone;
@property(nonatomic,strong) NSString* age;
@property(nonatomic,assign) NSInteger bookID;
@property(nonatomic,strong) NSArray<myModle*>* myModleArray;
@end
