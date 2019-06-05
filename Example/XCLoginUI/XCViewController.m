//
//  XCViewController.m
//  XCLoginUI
//
//  Created by fanxiaocong on 06/04/2019.
//  Copyright (c) 2019 fanxiaocong. All rights reserved.
//

#import "XCViewController.h"
#import <XCLoginUI/XCLoginUI.h>

@interface XCViewController ()

@end

@implementation XCViewController

- (void)dealloc
{
    NSLog(@"XCViewController --- dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 🎬 👀 Action Method 👀

- (IBAction)clickLogoutButtonAction:(id)sender
{
    XCLoginUI *vc = [XCLoginUI loginViewController];
    
    vc.logoImage = [UIImage imageNamed:@"login_logo"];
    vc.backgroundImage = [UIImage imageNamed:@"223"];
    
    vc.clickLoginCallback = ^(XCLoginUI * _Nonnull loginVc, NSString * _Nonnull account, NSString * _Nonnull password) {
        /// 点击登录，切换到首页
        [loginVc hide:^{
            XCViewController *homeVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            [UIApplication sharedApplication].keyWindow.rootViewController = homeVc;
        }];
    };
    
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

@end
