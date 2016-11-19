//
//  NSDate+BTExtension.h
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/13.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BTExtension)
//比较from和self的时间差值
-(NSDateComponents*)deltaFrom:(NSDate *)from;

//判断是否为今年
-(BOOL)isThisyear;

//判断是否为今天
-(BOOL)isToday;

//判断是否为昨天
-(BOOL)isYesterday;

@end
