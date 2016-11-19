//
//  BTLoginViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/5.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTLoginViewController.h"
#import "BTMeViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface BTLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewLeftMargin;

@property (weak, nonatomic) IBOutlet UILabel *LoginLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *registphone;
@property (weak, nonatomic) IBOutlet UIButton *getcode;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *registPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

@end

@implementation BTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //点击空白处退出键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
}
/** 关闭键盘 */
- (void)closeKeyboard:(id)sender{ [self.view endEditing:YES];}



- (IBAction)showLogin:(id)sender {
    
    
    //退出键盘
    [self.view endEditing:YES];
    self.LoginLabel.text=@"登录";
    self.LoginViewLeftMargin.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)forgetPassword:(id)sender {
}

//点击登录

- (IBAction)login:(id)sender {
    
    
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    if(username.length==0 || password.length==0){
        [SVProgressHUD showErrorWithStatus:@"用户名或密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=username;
    params[@"password"]=password;
    params[@"type"]=@"101";
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/user/login" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //登陆成功后把用户名和密码存储到UserDefault
        [userDefaults setObject:username forKey:@"name"];
        [userDefaults setObject:password forKey:@"password"];
        [userDefaults synchronize];
        NSLog(@"登录了");
        NSLog(@"aaaaaaa---%@",responseObject);
        //用模态跳转到主界面
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录bu了");
    }];
    
}

-(void)showLogin:(NSString *)username withPassword:(NSString *)password{
    //退出键盘
    [self.view endEditing:YES];
    self.LoginLabel.text=@"登录";
    self.LoginViewLeftMargin.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.usernameField.text =username;
    self.passwordField.text = password;

}

- (IBAction)showRegister:(id)sender {
    //退出键盘
    [self.view endEditing:YES];
    self.LoginLabel.text=@"注册";
    self.LoginViewLeftMargin.constant=- self.view.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}

//点击注册
- (IBAction)regist:(id)sender {
    NSString *phonenum = self.registphone.text;
    NSString *password = self.registPassword.text;
    NSString *confirm = self.confirmPassword.text;
    if(phonenum.length==0||password.length==0){
        [SVProgressHUD showErrorWithStatus:@"用户名或密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });

    }
    else if(![password isEqualToString:confirm]){
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });

    }
    else{
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=phonenum;
    params[@"password"]=password;
    params[@"phonenum"]=phonenum;

    params[@"type"]=@"100";
    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/user/join" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSLog(@"aaaaaaa------%@",responseObject);
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"re"]];
        if([str isEqualToString:[NSString stringWithFormat:@"6"]]){
            [SVProgressHUD showErrorWithStatus:@"用户已存在"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });

        }
        
        if([str isEqualToString:[NSString stringWithFormat:@"0"]]){
            NSLog(@"注册成功");
            [self showLogin:phonenum withPassword:password];
        }
          
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"注册失败");
    }];

    }
    
}

- (IBAction)showMe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
