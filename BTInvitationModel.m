//
//  BTInvitation.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/12.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTInvitationModel.h"

@implementation BTInvitationModel
-(NSString *)time{
    //设置日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    //当前时间
    //    NSDate *now = [NSDate date];
    //发帖时间
    NSDate *create = [fmt dateFromString:_time];
    
    if(create.isThisyear){//今年
        if(create.isToday){//今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if(cmps.hour>=1){//时间差距 >=1
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
            else if (cmps.minute>=1){//1小时 >时间差距 >=1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }
            else{
                return @"刚刚";
            }
        }
        else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else{//其它
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }
    else{
        return _time;
    }
    //    //日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //
    //    //比较时间
    //    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    NSDateComponents *cmps = [calendar components:unit fromDate:create toDate:now options:0];

}
@end
