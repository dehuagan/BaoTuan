//
//  BTNewsViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/10/31.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTNewsViewController.h"
#import <AFNetworking.h>
@interface BTNewsViewController ()

@end

@implementation BTNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    self.navigationItem.title=@"消息";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]=@"str";
    params[@"college"]=@"大学名";
    params[@"user_id" ] =@"id";
            
    [[AFHTTPSessionManager manager] POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/showLastestCollegeIntro" parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"%@",responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
    }];
    
}

@end



