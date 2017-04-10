//
//  registerPage.m
//  Bmob_application
//
//  Created by 小儿黑挖土 on 2017/4/7.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

#import "registerPage.h"
#import "AFNetWorkingHelper.h"
#import "MBProgressHUD.h"
#define KURLTypeRegister @"http://cloud.bmob.cn/a7050c0770aac9d4/registerUser"

@interface registerPage ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *certificatePwdField;

@end

@implementation registerPage{
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doRegister:(UIButton *)sender {
    if([self isInfoCompleted]){
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;//indicator,default
        hud.label.text = @"正在注册。。。";
        [self uploadPara];
    }
}

-(void)uploadPara{
    NSString *username = _usernameField.text;
    NSString *password = _passwordField.text;
    NSDictionary *para = @{@"username":username,@"password":password};
    
    AFNetWorkingHelper *helper = [AFNetWorkingHelper defaultHelper];
    [helper sendRequestWithURLString:KURLTypeRegister parameters:para success:^(NSURLSessionDataTask *task, NSDictionary *jsonObj) {
        [self successWithTask:task response:jsonObj];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self failureWithTask:task error:error];
    }];

}

//登录状态
-(void)successWithTask:(NSURLSessionTask *)task response:(NSDictionary *)data{
    if(data){
        //hud显示在异步网络请求前，消失在数据回传之后
        [hud hideAnimated:YES];
        NSString *msg = data[@"msg"];
        NSInteger code = [data[@"code"] integerValue];
        [self tipsAniamtion:msg];
        if(code == 200){
            [self performSelector:@selector(doDismiss) withObject:nil afterDelay:3];
        }
    }
}
-(void)doDismiss{
    //self.view不能向上调用viewController
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)failureWithTask:(NSURLSessionTask *)task error:(NSError *)error{
//    NSLog(@"register with error:%@",error.localizedDescription);
//    [self tipsAniamtion:error.localizedDescription];
}


-(BOOL)isInfoCompleted{
    if(_usernameField.text.length>0 && _passwordField.text.length>0 && _certificatePwdField.text.length>0){
        if([_passwordField.text isEqualToString:_certificatePwdField.text]){
            return YES;
        }else{
            //showTips
//            [self tipsAniamtion:@"密码输入不一致，请重新输入！"];
            _certificatePwdField.text = @"";
            return NO;
        }
    }else{
        return NO;
    }
}

-(void)tipsAniamtion:(NSString *)tips{
    [UIView animateWithDuration:3 animations:^{
        [self showTipsInHUD:tips];
    } completion:^(BOOL finished) {
        [hud hideAnimated:YES];
    }];
}

-(void)showTipsInHUD:(NSString *)tips{
//    if(!hud){
//        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }
//    if(!hud.isHidden){
//        [UIView animateWithDuration:1 animations:^{
//            [hud hideAnimated:YES];
//        }];
//    }
//    [hud hideAnimated:NO];
//    hud.mode = MBProgressHUDModeText;
//    hud.label.text= @"Tips";
//    hud.detailsLabel.text = tips;
    
    //hud不能用同一个？？showHUDAdddedTo先移除影藏的再添加？？
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text= @"Tips";
    hud.detailsLabel.text = tips;
}

//当textField输入完毕后，button从灰色变为蓝色

@end
