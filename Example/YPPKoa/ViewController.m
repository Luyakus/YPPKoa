//
//  ViewController.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//

#import "ViewController.h"
#import "YPPChatController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = UIColor.redColor;
    btn.frame = CGRectMake(100, 100, 70, 40);
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoChat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)gotoChat {
    YPPChatController *vc = [[YPPChatController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
