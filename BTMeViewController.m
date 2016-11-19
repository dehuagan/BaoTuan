//
//  BTMeViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/2.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTMeViewController.h"
#import "BTLoginViewController.h"
#import "BTUserDetailViewController.h"
#import "BTUserheader.h"
#import "BTStatusViewController.h"
#import "BTSendViewController.h"
@interface BTMeViewController ()<BTUserheaderDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIButton *fans;
@property (weak, nonatomic) IBOutlet UIButton *follow;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    //判断是否登陆，由登陆状态判断启动页面
    //获取UserDefault
    [self setupHeader];
}


-(void)setupHeader{
    BTUserheader *header = [BTUserheader cell];
    header.delegate = self;
    header.height=400;
    self.tableView.tableHeaderView.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = header;
}
#pragma mark - TermCellDelegate
- (void)chooseBtn:(UIButton *)button
{
    NSLog(@"wwwwwww--------%zd",button.tag);
        //_clickIndex = button.tag;
    if(button.tag==5){
        
        BTSendViewController *send = [[BTSendViewController alloc]init];
        [self presentViewController:send animated:YES completion:nil];
    }
    else{
        BTStatusViewController *status = [[BTStatusViewController alloc]init];
        status.tag =button.tag;
        [self.navigationController pushViewController:status animated:YES];
    }
        
    
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
- (IBAction)changeImage:(id)sender {
    BTLoginViewController *login = [[BTLoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark---uitableviewdatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSArray *titles = @[@"互相关注(好友)",@"帮助"];
    NSUInteger row = [indexPath row];
    cell.textLabel.text = titles[row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;


}

@end
