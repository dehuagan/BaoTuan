//
//  BTRecommendViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/6.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTRecommendViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "BTInvitationModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "BTInvitationCell.h"
#import "BTInvitationViewController.h"
@interface BTRecommendViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *invitations;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) NSString *length;

@end

@implementation BTRecommendViewController
-(NSMutableArray *)invitations
{
    if(!_invitations){
        _invitations = [NSMutableArray array];
    }
    return _invitations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    //刷新
    [self setupRefresh];
    
    
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

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadInvitation)];
    
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInvitations)];
    //    self.tableView.mj_footer.hidden=YES;
}





#pragma mark 数据处理
/** 加载新数据*/
-(void)loadInvitation{
    self.from=0;
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=@"d78bbb902b1890d5f2d5b85872f0143c";
    params[@"user_id"]=@"35";
    params[@"type"]=@"400";
    params[@"key"]=@"实";
    //发送请求
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/search/searchIntro" parameters:params success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        NSLog(@"ttttttt--------%@",responseObject);
        
        //字典转模型
        self.invitations=[BTInvitationModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
        NSLog(@"sssss---------%@",self.invitations);
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)loadMoreInvitations{
    self.from+=[self.length integerValue];
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=@"d78bbb902b1890d5f2d5b85872f0143c";
    params[@"user_id"]=@"35";
    params[@"type"]=@"400";
    params[@"key"]=@"实";
    params[@"from"]=[NSString stringWithFormat:@"%zd",self.from];
    //发送请求
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/search/searchIntro" parameters:params success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        NSLog(@"ttttttt--------%@",responseObject);
        //字典转模型
        
        NSArray *newInvitations =[BTInvitationModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
        [self.invitations addObjectsFromArray:newInvitations];
        NSLog(@"sssss---------%@",self.invitations);
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}



#pragma mark - TableViewDataSource
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
    detail.invitation = self.invitations[indexPath.row];
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
