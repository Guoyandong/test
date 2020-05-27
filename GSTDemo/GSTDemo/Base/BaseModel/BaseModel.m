//
//  baseModel.m
//  GQ_****
//
//  Created by Madodg on 2017/12/8.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "BaseModel.h"
#import "myModle.h"
#import <objc/runtime.h>
@implementation BaseModel
/**
 key的更换
 "n":"Harry Pottery",
 return @{@"name" : @"n",}
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"n",
             @"phone" : @"p",
             @"bookID" : @[@"id",@"ID",@"book_id"]};
}

/**
 数组里面模型确认
 "n":"Harry Pottery",
 NSMutableDictionary *attachments; //Dict<NSString,Attachment>
 return @{@"name" : @"n",}
 */
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"myModleArray" : [myModle class],
             @"attachments" : @"Attachment" };
}

- (NSDictionary*)toDictionary{
    NSMutableDictionary* dic = [NSMutableDictionary new];
    NSArray* properNames = [[self class] allPropertyNames];
    [properNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:[self valueForKey:obj] forKey:obj];
    }];
    return dic;
}

+ (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

+ (char *)getPropertyType:(NSString *)property
{
    objc_property_t specific_property = class_getProperty([self class], [property UTF8String]);
    if ( property == NULL )
        return ( NULL );
    return property_copyAttributeValue(specific_property, "T");
}

- (NSMutableArray *)addObserverToEachProperties
{
    unsigned count;
    objc_property_t* properties = class_copyPropertyList([self class], &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        NSString *stringPropertyName = [NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        [self addObserver:self forKeyPath:stringPropertyName options:NSKeyValueObservingOptionNew context:nil];
        [propertyArray addObject:stringPropertyName];
    }
    return propertyArray;
}
@end
