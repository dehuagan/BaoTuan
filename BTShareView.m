//
//  BTShareView.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/14.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTShareView.h"
#import <Masonry.h>
#define AnimateDuration     0.4
@implementation BTShareView

//- (instancetype)init{
//    
//    self = [super init];
//    if (self) {
//        [self setup];
//    }
//    return self;
//}
//
//- (void)setup{
//    
//    //弹出菜单，添加半透明背景
//    _backView = [UIButton buttonWithType:UIButtonTypeCustom];
//    _backView.frame = CGRectMake(0, 0, self.width, self.height);
//    _backView.alpha = 0.3;
//    _backView.backgroundColor = [UIColor blackColor];
//    [_backView addTarget:self action:@selector(backViewClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ShareMenuHeight);
//    self.backgroundColor = [UIColor whiteColor];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
//    
//    NSMutableArray *shareTitleArray = [[NSMutableArray alloc]initWithObjects:@"QQ",@"QQ空间",@"微信",@"朋友圈",@"复制链接", nil];
//    NSMutableArray *shareIconArray = [[NSMutableArray alloc]initWithObjects:@"news_control_center_qq",@"news_control_center_zone",@"news_control_center_wechat",@"news_control_center_wechatQ",@"news_control_center_link", nil];
//    
//    
//    for (int i = 0; i < shareIconArray.count; i ++) {
//        
//        UIButton *itemView = [UIButton buttonWithType:UIButtonTypeCustom];
//        itemView.backgroundColor = [UIColor clearColor];
//        itemView.tag = i;
//        [itemView addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:itemView];
//        
//        //图标
//        UIImageView *icon = [[UIImageView alloc]init];
//        icon.backgroundColor = [UIColor clearColor];
//        icon.image = [UIImage imageNamed:shareIconArray[i]];
//        [itemView addSubview:icon];
//        
//        //标题
//        UILabel *title = [[UILabel alloc]init];
//        title.font = [UIFont systemFontOfSize:13.0f];
//        title.backgroundColor = [UIColor clearColor];
//        [title sizeToFit];
//        title.text = shareTitleArray[i];
//        [itemView addSubview:title];
//        
//        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@70);
//            make.width.equalTo(@(SCREEN_WIDTH*1/4));
//            make.left.equalTo(self.mas_left).offset((SCREEN_WIDTH*(i%4)/4));
//            make.top.equalTo(self.mas_top).offset(70*(i/4));
//            //            if (i == shareIconArray.count - 1) {
//            //                make.bottom.equalTo(self.mas_bottom).offset(-10);
//            //            }
//        }];
//        
//        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.width.equalTo(@40);
//            make.top.equalTo(itemView.mas_top).offset(10);
//            make.centerX.equalTo(itemView.mas_centerX);
//        }];
//        
//        [title mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(itemView.mas_centerX);
//            make.top.equalTo(icon.mas_bottom).offset(5);
//            make.bottom.equalTo(itemView.mas_bottom);
//        }];
//        
//    }
//}
//
//- (void)backViewClicked:(id)sender{
//    [self hide];
//}
//
//- (void)show{
//    
//    [[[UIApplication sharedApplication] keyWindow] addSubview:_backView];
//    [[[UIApplication sharedApplication] keyWindow] insertSubview:self aboveSubview:_backView];
//    
//    [UIView animateWithDuration:AnimateDuration animations:^{
//        
//        self.frame = CGRectMake(0, SCREEN_HEIGHT - ShareMenuHeight, SCREEN_WIDTH, ShareMenuHeight);
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//}
//
//- (void)hide{
//    
//    [_backView removeFromSuperview];
//    
//    [UIView animateWithDuration:AnimateDuration animations:^{
//        
//        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ShareMenuHeight);
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    
//}
//
//- (void)share:(id)sender{
//    UIButton *button = (UIButton *)sender;
//    if (self.shareButtonClickBlock) {
//        self.shareButtonClickBlock(button.tag);
//    }
//}
@end
