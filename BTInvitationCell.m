    //
//  BTInvitationCell.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/12.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTInvitationCell.h"
#import "BTInvitationModel.h"
#import <UIImageView+WebCache.h>
@interface BTInvitationCell()
/** 配图 */
@property (weak, nonatomic) IBOutlet UIImageView *PeituImage;
/** 分类标签 */
@property (weak, nonatomic) IBOutlet UILabel *cateLabel;
/** 题目 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 学校 */
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
/** 要求 */
@property (weak, nonatomic) IBOutlet UILabel *needLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 人数 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end
@implementation BTInvitationCell

-(void)setInvitation:(BTInvitationModel *)invitation
{
    _invitation = invitation;
    [self.PeituImage sd_setImageWithURL:[NSURL URLWithString:invitation.image] placeholderImage:[UIImage imageNamed:@"tua"]];
    self.titleLabel.text = invitation.title;
    self.needLabel.text = [NSString stringWithFormat:@"要求：%@",invitation.need];
    self.countLabel.text = [NSString stringWithFormat:@"%zd人",invitation.neednum ];
    self.schoolLabel.text = invitation.college;
    self.cateLabel.text = invitation.domain;
    self.timeLabel.text = invitation.time;
    
}
-(void)setFrame:(CGRect)frame{
    frame.size.height -=10;
    frame.origin.y+=10;
    [super setFrame:frame];
}
@end
