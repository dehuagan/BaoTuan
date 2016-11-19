//
//  BTClassifyViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/10/31.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTClassifyViewController.h"
#import "BTPopViewController.h"
#import "BTRecommendViewController.h"
#import "BTInViewController.h"
#import "BTOutViewController.h"
@interface BTClassifyViewController ()<UIScrollViewDelegate>

/** 底部的绿色横线 */
@property (nonatomic, weak) UIView *indicatorView;
/** 被选中的按钮 */
@property (nonatomic, weak) UIButton *seletedButton;
/** 顶部标签 */
@property (nonatomic, weak) UIView *titleView;

/** 底部视图 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation BTClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self.navigationController setNavigationBarHidden:YES];
    //设置顶部标签栏
     [self setupTitleView];
    //初始化子控制器
    [self setupChildVc];
    //设置内容
    [self setupContentView];
    
//    self.navigationController.hidesBarsOnSwipe = YES ;
    
}


    

//设置导航栏内容
//-(void)setupNav{

//    UISearchBar *searchbar=[[UISearchBar alloc]init];
//    self.searchBar=searchbar;
//    self.navigationItem.titleView=self.searchBar;
//    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
//    if (searchField) {
//        [searchField setBackgroundColor:[UIColor whiteColor]];
//        searchField.layer.cornerRadius = 10.0f;
//        searchField.layer.borderColor = [UIColor blackColor].CGColor;
//        searchField.layer.borderWidth = 1;
//        searchField.layer.masksToBounds = YES;
//        
//    }
//    
//    self.view.backgroundColor=[UIColor whiteColor];
//
//    
//}
 //设置顶部标签栏
-(void)setupTitleView{
    
    //标签栏整体
    UIView *titleView=[[UIView alloc]init];
    titleView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:1.0];
    titleView.width=self.view.width;
    titleView.height=60;
    titleView.y=0;
    [self.view addSubview:titleView];
    self.titleView=titleView;
    //内部子标签
    NSInteger count=4;
    CGFloat width=titleView.width/count;
    //底部的绿色横线
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.tag=-1;
    indicatorView.backgroundColor=[UIColor colorWithRed:0/255.0 green:205/255.0 blue:102/255.0 alpha:1.0];
    indicatorView.height=2;
    indicatorView.y=titleView.height-indicatorView.height;
   
    self.indicatorView=indicatorView;
    NSArray *titles=@[@"热门",@"推荐",@"校内",@"校外"];
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=i;
        btn.width=width;
        btn.y = 20;
        btn.height=titleView.height-btn.y;
        btn.x=i*width;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
//        [btn layoutIfNeeded];//强制布局
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:205/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateDisabled];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        //默认点击了第一个按钮
        if(i==0){
            btn.enabled=NO;
            self.seletedButton=btn;
            [btn.titleLabel sizeToFit];
            self.indicatorView.width=btn.titleLabel.width;
            self.indicatorView.centerX=btn.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}

-(void)titleClick:(UIButton *)button{
    //修改按钮状态
    self.seletedButton.enabled=YES;
    button.enabled=NO;
    self.seletedButton=button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width=button.titleLabel.width;
        self.indicatorView.centerX=button.centerX;
    }];
    
    //滚动
    CGPoint offset=self.contentView.contentOffset;
    offset.x=button.tag*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
}
//设置内容
-(void)setupContentView{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView *contentView=[[UIScrollView alloc]init];

    contentView.frame=self.view.bounds;
   
    contentView.delegate=self;
    //实现分页
    contentView.pagingEnabled=YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize=CGSizeMake(contentView.width*self.childViewControllers.count, 0);
    self.contentView=contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
//设置子控制器
-(void)setupChildVc{
    BTPopViewController *pop=[[BTPopViewController alloc]init];
    BTRecommendViewController *recommend=[[BTRecommendViewController alloc]init];
    BTInViewController *in=[[BTInViewController alloc]init];
    BTOutViewController *out=[[BTOutViewController alloc]init];
    [self addChildViewController:pop];
    [self addChildViewController:recommend];
    [self addChildViewController:in];
    [self addChildViewController:out];
}


#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前的索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //取出子控制器
    UITableViewController *vc=self.childViewControllers[index];
    vc.view.x=scrollView.contentOffset.x;
    vc.view.y=0;
    vc.view.height=scrollView.height;
    //设置内边距
    CGFloat bottom=self.tabBarController.tabBar.height;
    CGFloat top=CGRectGetMaxY(self.titleView.frame);
    vc.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets=vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titleView.subviews[index]];
}


@end
