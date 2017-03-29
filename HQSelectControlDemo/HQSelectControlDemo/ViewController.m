//
//  ViewController.m
//  HQSelectControlDemo
//
//  Created by babyrabbit on 2017/3/29.
//  Copyright © 2017年 zeroLee. All rights reserved.
//

#import "ViewController.h"
#import "HQSelectControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    HQSelectControl* view1 = [[HQSelectControl alloc]initWithFrame:CGRectMake(0, 184, [UIScreen mainScreen].bounds.size.width, 50) datas:@[@"viewController",@"UILable",@"UIButton",@"UIView",@"viewController",@"UILable",@"UIButton",@"UIView"]];
    view1.color_backGorudColor_normal = [UIColor clearColor];
    view1.color_backGorudColor_selected = [UIColor clearColor];
    view1.color_textColor_normal = [UIColor purpleColor];
    view1.color_textColor_selected = [UIColor blackColor];
    view1.font_textFont_normal = [UIFont systemFontOfSize:18];
    view1.font_textFont_selected = [UIFont systemFontOfSize:19];
    view1.currentIndex = 1;
    [self.view addSubview:view1];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
