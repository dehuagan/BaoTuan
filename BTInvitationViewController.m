//
//  BTInvitationViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/15.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTInvitationViewController.h"
#import "BTInvitationModel.h"
#import <AFNetworking.h>
@interface BTInvitationViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *invationDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *collegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *neednumLabel;
@property (weak, nonatomic) IBOutlet UILabel *existnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *needLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *tab;
@property (weak, nonatomic) IBOutlet UIButton *applybtn;
@property (weak, nonatomic) IBOutlet UIButton *chatbtn;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *collectbtn;


@end

@implementation BTInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self.applybtn setImage:[UIImage imageNamed:@"Rectangle 259"] forState:UIControlStateSelected];
    [self.chatbtn setImage:[UIImage imageNamed:@"Rectangle 260"] forState:UIControlStateSelected];
    [self.likebtn setImage:[UIImage imageNamed:@"Rectangle 261"] forState:UIControlStateSelected];
    [self.collectbtn setImage:[UIImage imageNamed:@"Rectangle 262"] forState:UIControlStateSelected];
    [self setupView];
}

-(void)setupNav{
    self.navigationItem.title = @"抱团邀请函";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share-1"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)setupView{
    self.titleLabel.text = self.invitation.title;
    self.collegeLabel.text = self.invitation.college;
    self.timeLabel.text = self.invitation.time;
    self.existnumLabel.text = [NSString stringWithFormat:@"现有团员：%@人",self.invitation.existnum];
    NSInteger restnum = self.invitation.neednum-[self.invitation.existnum integerValue];
    self.neednumLabel.text = [NSString stringWithFormat:@"限定团员人数：%zd人",self.invitation.neednum];
    self.restLabel.text =[NSString stringWithFormat:@"剩余名额：%zd人",restnum];
    self.timeLabel.text = self.invitation.time;
    self.needLabel.text = [NSString stringWithFormat:@"抱团要求：%@",self.invitation.need];
    self.textLabel.text = self.invitation.text;
}

@end
