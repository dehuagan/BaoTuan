//
//  BTSendViewController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/11/18.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTSendViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface BTSendViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailField;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;
@property (weak, nonatomic) IBOutlet UIImageView *tempImage;

@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UITextField *classifyField;

@end

@implementation BTSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
    //点击空白处退出键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}


- (IBAction)return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)send:(id)sender {
    
    NSString *title = self.titleField.text;
    NSString *text =self.detailField.text;
    NSString *neednum = self.countField.text;
    NSString *college = self.school.text;
    NSString *domain = self.classifyField.text;

    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=@"ca228ff8002d4f96ed9fe6cabda6a05d";
    params[@"user_id"]=@"40";
    params[@"type"]=@"200";
    
    params[@"domain"]=domain;
    params[@"title"]=title;
    params[@"text"]=text;
    params[@"neednum"]=neednum;
    params[@"college"]=college;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/addIntroduce" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //在这个block中设置需要上传的文件
        NSData *data = UIImagePNGRepresentation(self.tempImage.image);
        [formData appendPartWithFileData:data name:@"img[]" fileName:@"test.png" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self.view endEditing:YES];
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });

        NSLog(@"ooooooo-----%@",responseObject);
        NSLog(@"oooooo---图片上传成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ooooo-----上传失败");
    }];

}
    

    //参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"token"]=@"ca228ff8002d4f96ed9fe6cabda6a05d";
//    params[@"user_id"]=@"40";
//    params[@"type"]=@"200";
//    
//    params[@"domain"]=domain;
//    params[@"text"]=text;
//    params[@"need"]=need;
//    params[@"neednum"]=neednum;
//    params[@"college"]=college;
//    [[AFHTTPSessionManager manager]POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/addIntroduce" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"lllljsahfj-------%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"lllljsahfj-------失败");
//    }];
//    
//}

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
//    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
//    
//    [manager POST:@"http://121.42.203.85/baotuan/index.php/home/introduce/addIntroduce" parameters:baseDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"Filedata"fileName:@"test.jpg"mimeType:@"image/jpg"];
//    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
//        // upload succ
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//        NSLog(@"#######upload error%@", error);
//    }];
    
    

- (IBAction)nextstep:(id)sender {
      //退出键盘
    [self.view endEditing:YES];
    
    self.LoginViewLeftMargin.constant=- self.view.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    


}

- (IBAction)showSend:(id)sender {
    //退出键盘
    [self.view endEditing:YES];
    self.LoginViewLeftMargin.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 关闭键盘 */
- (void)closeKeyboard:(id)sender{ [self.view endEditing:YES];}
- (IBAction)addImage:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    

}

#pragma mark 从摄像头获取图片或视频
//- (void)selectImageFromCamera
//{
//    }
#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info{
    UIImage *original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageWriteToSavedPhotosAlbum(original_image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:),
                                   nil);
    self.tempImage.image = original_image;
    [self dismissViewControllerAnimated:YES completion:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // Pre iOS 8 -- No camera auth required.
        
    }else {
        // iOS 8 后，全部都要授权
        
        // Thanks: http://stackoverflow.com/a/24684021/2611971
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined:{
                // 许可对话没有出现，发起授权许可
                
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    
                    if (granted) {
                        //第一次用户接受
                    }else{
                        //用户拒绝
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized:{
                // 已经开启授权，可继续
                
                break;
            }
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                // 用户明确地拒绝授权，或者相机设备无法访问
                
                break;
            default:
                break;
        }
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSMutableDictionary * dict= [NSMutableDictionary dictionaryWithDictionary:editingInfo];
    
    [dict setObject:image forKey:@"UIImagePickerControllerEditedImage"];
    
    //直接调用3.x的处理函数
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}


@end
