//
//  ViewController.m
//  JLInputViewCode
//
//  Created by 张天龙 on 17/3/28.
//  Copyright © 2017年 张天龙. All rights reserved.
//

#import "ViewController.h"
#import "JLToobar.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加工具条
    CGFloat chatbarH = 46;
    JLToobar *chatbar = [[JLToobar alloc] initWithFrame:CGRectMake(0, kScreenH-chatbarH, kScreenW, chatbarH)];
    [self.view addSubview:chatbar];
    
}


@end
