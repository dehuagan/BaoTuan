//
//  BTHomeViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/10/31.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTHomeViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "BTInvitationModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "BTInvitationCell.h"
#import "BTInvitationViewController.h"
#import "BTSearchController.h"
@interface BTHomeViewController ()<UIScrollViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic, strong) BTSearchController *searchResult;
@property (nonatomic, strong) UISearchController *svc;
@property (nonatomic, strong) NSMutableArray *invitations;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) NSString *length;

@end

@implementation BTHomeViewController
////     BOOL _isHidding;
//}
-(NSMutableArray *)invitations
{
    if(!_invitations){
        _invitations = [NSMutableArray array];
    }
    return _invitations;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNav];
    
    [self setupTableView];
    //刷新
    [self setupRefresh];
    
    
//    self.searchResult = [[BTSearchController alloc]init];
//    self.svc = [[UISearchController alloc]initWithSearchResultsController:self.searchResult];
    
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

//设置导航栏内容
-(void)setupNav{
    self.searchResult = [[BTSearchController alloc]init];
    self.svc = [[UISearchController alloc]initWithSearchResultsController:self.searchResult];
    self.svc.searchResultsUpdater = self;
    self.svc.searchBar.delegate = self;
    self.navigationItem.titleView=self.svc.searchBar;
    self.definesPresentationContext=YES;
    UITextField *searchField = [self.svc.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 10.0f;
        searchField.layer.borderColor = [UIColor blackColor].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];

}

#pragma mark 数据处理
/** 加载新数据*/
-(void)loadInvitation{
    self.from=0;
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=@"ca228ff8002d4f96ed9fe6cabda6a05d";
    params[@"user_id"]=@"40";
    params[@"type"]=@"201";
    params[@"from"]=[NSString stringWithFormat:@"%zd",self.from];
    //发送请求
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/showLastestCollegeIntro" parameters:params success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        //储存length
        self.length = responseObject[@"length"];
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
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=@"ca228ff8002d4f96ed9fe6cabda6a05d";
    params[@"user_id"]=@"40";
    params[@"type"]=@"201";
    params[@"from"]=[NSString stringWithFormat:@"%zd",self.from];
    
    //发送请求
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/showLastestCollegeIntro" parameters:params success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
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


#pragma mark - 上拉隐藏navigation bar

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];

    
    [self.navigationController setNavigationBarHidden:translation.y<0 animated:YES];
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //获取到用户输入的数据
    NSString *searchText=searchController.searchBar.text;
    NSLog(@"qqopojj-----%@",searchText);
    if(searchText.length!=0){
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"tey"]=searchText;
    params[@"type"]=@"400";
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/search/searchIntro" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典转模型
        self.searchResult.invitations=[BTInvitationModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
        NSLog(@"ddddddddddfffffff---------%@",self.searchResult.invitations);
        [self.searchResult.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    

    }
}
    


#pragma mark - UISearchBarDelegate
/**点击按钮后，进行搜索页更新*/
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.svc];
}





@end
