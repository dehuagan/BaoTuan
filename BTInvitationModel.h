//
//  BTInvitation.h
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/12.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTInvitationModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;

/** 要求*/
@property (nonatomic, copy) NSString *need;
@property (nonatomic, assign) NSInteger neednum;
@property (nonatomic, copy) NSString *existnum;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *college;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger collectnum;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *domain;
-(NSString *)time;
@end
/**
 "re": 0,
 "type": 201,
 "msg": [
 {
 "id": "118",
 "user_id": "40",
 "title": "",
 "text": "画画",
 "time": "2016-11-19 13:37:28",
 "collectnum": "0",收藏数
 "need": "一起去画画",
 "neednum": "5",
 "college": "广外",
 "existnum": "0",  现有团员
 "username": "123",
 "face": null,
 "image": "http://121.42.203.85/baotuan/Uploads/2016-11-19/582fe5188f59a.png",
 "domain": "画画" */
