//
//  Basepage.m
//  Bmob_application
//
//  Created by 小儿黑挖土 on 2017/4/7.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

#import "Basepage.h"

@interface Basepage ()

@end

@implementation Basepage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createItem];
}

-(void)createItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

-(void)doBack{
    [self.navigationController popViewControllerAnimated:true];
}


@end
