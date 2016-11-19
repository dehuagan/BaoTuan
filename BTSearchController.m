//
//  BTSearchController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/18.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTSearchController.h"
#import "BTInvitationCell.h"
#import "BTInvitationViewController.h"
@interface BTSearchController ()

@end

@implementation BTSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

static NSString * const BTInvitationCellID = @"invitation";
-(void)setupTableView{
    //设置内边距
    //    CGFloat bottom=self.tabBarController.tabBar.height;
    //    CGFloat top=CGRectGetMaxY(self.navigationController.navigationBar.frame);
    //    self.tableView.contentInset=UIEdgeInsetsMake(0, 10, bottom, 0);
    self.tableView.scrollIndicatorInsets=self.tableView.contentInset;
    //    self.tableView.y=10;
    //    self.tableView.x=0;
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BTInvitationCell class]) bundle:nil] forCellReuseIdentifier:BTInvitationCellID];
    
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.invitations.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BTInvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:BTInvitationCellID];
    
    cell.invitation=self.invitations[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    BTInvitationViewController *detail = [[BTInvitationViewController alloc]init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:detail animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
#pragma mark -代理方法
//cell的边距
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


@end
