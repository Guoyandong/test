//
//  baseModel.h
//  GQ_****
//
//  Created by Madodg on 2017/12/8.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseModel : NSObject

+ (NSArray *)allPropertyNames;
+ (char *)getPropertyType:(NSString *)property;
- (NSMutableArray *)addObserverToEachProperties;
- (NSDictionary*)toDictionary;
@end
