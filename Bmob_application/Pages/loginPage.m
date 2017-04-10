//
//  loginPage.m
//  Bmob_application
//
//  Created by 小儿黑挖土 on 2017/4/7.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

#import "loginPage.h"
#import "registerPage.h"
#import "AFNetWorkingHelper.h"
#import "MBProgressHUD.h"
#define kURLTypeLogin @"http://cloud.bmob.cn/a7050c0770aac9d4/doLogin"

@interface loginPage ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation loginPage
{
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(pushRegisterPage)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

-(void)pushRegisterPage{
    registerPage *vc = [[registerPage alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
- (IBAction)doLogin:(UIButton *)sender {
    if([self isNotEmpty]){
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;//indicator,default
        hud.label.text = @"正在登录。。。";
        
        AFNetWorkingHelper *helper = [AFNetWorkingHelper defaultHelper];
        NSString *username = _usernameField.text;
        NSString *password = _passwordField.text;
        NSDictionary *para = @{@"username":username,@"password":password};
        [helper sendRequestWithURLString:kURLTypeLogin parameters:para success:^(NSURLSessionDataTask *task, NSDictionary *responseObj) {
            //
            [hud hideAnimated:YES];
            NSInteger code = [responseObj[@"code"] integerValue];
            NSString *msg = responseObj[@"msg"];//直接转，不然报CFStringRef错？？？
            [self tipsAniamtion:msg];
            if(code == 200){
                [self performSelector:@selector(doDismiss) withObject:nil afterDelay:3];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //
            [hud hideAnimated:YES];
            [self tipsAniamtion:error.localizedDescription
             ];
        }];
    }
}

-(void)doDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)isNotEmpty{
    if(_usernameField.text.length>0 && _passwordField.text.length>0){
        return true;
    }else{
        NSString *tips = @"";
        if(_usernameField.text.length == 0){
            if([tips isEqualToString:@""]){
                tips =[NSString stringWithFormat:@"请先输入用户名！"];
            }else{
                tips =[NSString stringWithFormat:@"%@\n请先输入用户名！",tips];
            }
        }
        if(_passwordField.text.length == 0){
            if([tips isEqualToString:@""]){
                tips =[NSString stringWithFormat:@"请先输入密码！"];
            }else{
                tips =[NSString stringWithFormat:@"%@\n请先输入用户名！",tips];
            }
        }
        return NO;
    }
}

//MBProgressHUD
-(void)tipsAniamtion:(NSString *)tips{
    [UIView animateWithDuration:3 animations:^{
        [self showTipsInHUD:tips];
    } completion:^(BOOL finished) {
        [hud hideAnimated:YES];
    }];
}

-(void)showTipsInHUD:(NSString *)tips{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text= @"Tips";
    hud.detailsLabel.text = tips;
}

@end
