//
//  ViewController.m
//  Bmob_application
//
//  Created by 小儿黑挖土 on 2017/4/7.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

#import "ViewController.h"
#import "loginPage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(id)sender {
    loginPage *vc = [[loginPage alloc] init];
    UINavigationController *navCtr =  [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navCtr animated:true completion:nil];
}

@end
