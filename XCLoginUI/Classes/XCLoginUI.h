//
//  XCLoginViewController.h
//  Pods-XCLoginUI_Example
//
//  Created by 樊小聪 on 2019/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCLoginUI : UIViewController

/// Logo图片，default nil
@property (strong, nonatomic) UIImage *logoImage;
/// 背景图片，default nil
@property (strong, nonatomic) UIImage *backgroundImage;
/// 隐藏密码关闭的图片（密码可见）
@property (strong, nonatomic) UIImage *secureTextEntryOffImage;
/// 隐藏密码打开的图片（密码不可见）
@property (strong, nonatomic) UIImage *secureTextEntryOnImage;

/// 输入框的背景颜色，default whiteColor
@property (strong, nonatomic) UIColor *inputBackgroundColor;
/// 输入框的文字颜色，default whiteColor
@property (strong, nonatomic) UIColor *inputTextColor;
/// 输入框的文字大小，default 15
@property (assign, nonatomic) CGFloat inputTextFontSize;

/// loginButton
/// 登录按钮文字，default 登录
@property (copy, nonatomic) NSString *loginButtonTitle;
/// 登录按钮文字大小 default 15
@property (assign, nonatomic) CGFloat loginButtonTitleFontSize;
/// 登录按钮文字颜色 default white
@property (strong, nonatomic) UIColor *loginButtonTitleColor;
/// 登录按钮背景颜色 default #28A27A
@property (strong, nonatomic) UIColor *loginButtonBackgroundColor;

/// 默认账号，default nil
@property (copy, nonatomic) NSString *defaultAccount;
/// 默认密码，default nil
@property (copy, nonatomic) NSString *defaultPassword;
/// 账号的 placeholder，default 请输入账号
@property (copy, nonatomic) NSString *accountPlaceholder;
/// 密码的 placeholder，default 请输入密码
@property (copy, nonatomic) NSString *passwordPlaceholder;

/// 账号输入框的类型，default UIKeyboardTypeASCIICapable
@property (assign, nonatomic) UIKeyboardType accountInputKeyboardType;

/**
 *  点击登录的回调
 */
@property (copy, nonatomic) void(^clickLoginCallback)(XCLoginUI *vc, NSString *account, NSString *password);

/**
 *  隐藏
 *
 *  @param complete 完成的回调
 */
- (void)hide:(void(^)(void))complete;

/**
 *  登录控制器
 */
+ (instancetype)loginViewController;

@end

NS_ASSUME_NONNULL_END
