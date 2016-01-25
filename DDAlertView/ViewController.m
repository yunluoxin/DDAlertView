//
//  ViewController.m
//  DDAlertView
//
//  Created by 张小冬 on 16/1/23.
//  Copyright © 2016年 dadong. All rights reserved.
//

#import "ViewController.h"
#import "DDAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor greenColor];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss
{
    [DDAlertView dismiss];
}

//Demo
- (IBAction)ddd:(id)sender {
    DDAlertView *alertView =[[DDAlertView alloc]initWithTitle:@"哈哈" message:@"这是个测试" cancelButtonTitle:@"不干了" cancelBlock:^{
        NSLog(@"取消的操作");
    } otherButtonTitle:@"好的" otherBlock:^{
        NSLog(@"OK被点击");
    }];
    alertView.mode = DDAlertViewClosedAllowed ;
//    [self.view addSubview:view];
    [alertView show];
}

- (IBAction)aaa:(UIButton *)sender {
    DDAlertView *view = [[DDAlertView alloc]initWithTitle:@"提示" message:@"单个可以关闭的的。。。。。" cancelButtonTitle:@"我要关闭" cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
    view.mode = DDAlertViewClosedAllowed ;
    [view show];
}
- (IBAction)hhh:(id)sender {
    DDAlertView *view = [[DDAlertView alloc]initWithTitle:@"提示" message:@"2015年5月28日，Google I/O大会上正式推出Android M\n全新的Android M相比目前的Android Lollipop（5.0）有六项重大的改进：\n1.App Permissions（软件权限管理）：在Android M里，应用许可提示可以自定义了。\n2.Chrome Custom Tabs（网页体验提升）：新版的M对于Chrome的网页浏览体验进行了提升，它对登陆网站、存储密码、自动补全资料、多线程浏览网页的安全性进行了一些列的优化。\n3.App Links（APP关联）：Android M加强了软件间的关联。\n4.Android Pay（安卓支付）：Android支付统一标准。.Fingerprint Support（指纹支持）：Android M增加了对指纹的识别API。\n6.Power & Change（电量管理 ）：新的电源管理模块将更为智能，比如Android平板长时间不移动时，M系统将自动关闭一些App。同时Android M设备将支持USB Type-C接口，新的电源管理将更好的支持Type-C接口。[1]" cancelButtonTitle:@"立即更新" cancelBlock:^(){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//        [DDAlertView dismiss];
    } otherButtonTitle:nil otherBlock:nil];
    view.mode = DDAlertViewClosedNoAllowed ;
    [view show];
}

@end
