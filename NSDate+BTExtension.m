//
//  NSDate+BTExtension.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/13.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "NSDate+BTExtension.h"

@implementation NSDate (BTExtension)
-(NSDateComponents*)deltaFrom:(NSDate *)from
{
//    //设置日期格式
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间
//    NSDate *create = [fmt dateFromString:invitation.time];
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];

}


//判断是否为今年
-(BOOL)isThisyear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

//判断是否为今天
-(BOOL)isToday
{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSString *selfStr = [fmt stringFromDate:self];
    return [nowStr isEqualToString:selfStr];

    
}

//判断是否为昨天
-(BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return cmps.year ==0 && cmps.month == 0 && cmps.day ==1;

}

@end
