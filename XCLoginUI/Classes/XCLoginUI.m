//
//  XCLoginViewController.m
//  Pods-XCLoginUI_Example
//
//  Created by 樊小聪 on 2019/6/4.
//

#import "XCLoginUI.h"
#import <XCMacros/XCMacros.h>


#define kDelayRatio     0.2


@interface XCLoginUI ()

/** 👀 LOGO 图标底部背景视图与输入框视图的距离的约束 👀 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoBgViewBottomToInputConstraint;
/** 👀 LOGO 底部背景视图 👀 */
@property (weak, nonatomic) IBOutlet UIView *logoBgView;
/** 👀 表单底部的容器视图 👀 */
@property (weak, nonatomic) IBOutlet UIView *inputsContainerView;

/// 背景视图
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
/// Logo视图
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
/** 👀 账号输入框底部的背景视图 👀 */
@property (weak, nonatomic) IBOutlet UIView *accountFBgView;
/** 👀 密码输入框底部的背景视图 👀 */
@property (weak, nonatomic) IBOutlet UIView *passwordFBgView;
/** 👀 手机号输入框 👀 */
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
/** 👀 密码输入框 👀 */
@property (weak, nonatomic) IBOutlet UITextField *passwordF;
/// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/// 控制密码显示/隐藏的按钮
@property (weak, nonatomic) IBOutlet UIButton *entryButton;

@end

@implementation XCLoginUI

#pragma mark - ⏳ 👀 LifeCycle Method 👀

- (void)dealloc
{
    DLog(@"XCLoginUI --- dealloc");
    
    /// 移除通知
    [self removeNotification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// 设置 UI
    [self setupUI];
    
    /// 注册通知
    [self registerNotification];
    
    /// 出现
    [self show];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

#pragma mark - ✏️ 🖼 SetupUI Method 🖼

/**
 *  设置 UI
 */
- (void)setupUI
{
    /// 设置样式
    self.logoBgViewBottomToInputConstraint.constant = FetchCurrentHeightFromIphone6Height(80);
    self.logoBgView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    /// 添加点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewAction)]];
    
    /// 设置数据
    self.phoneF.text    = self.defaultAccount;
    self.phoneF.placeholder = self.accountPlaceholder ?: @"请输入账号";
    self.passwordF.text = self.defaultPassword;
    self.passwordF.placeholder = self.passwordPlaceholder ?: @"请输入密码";
    self.backgroundImageView.image = self.backgroundImage;
    self.logoImageView.image = self.logoImage;
    self.accountFBgView.backgroundColor = self.inputBackgroundColor ?: [UIColor whiteColor];
    self.phoneF.textColor = self.inputTextColor ?: [UIColor blackColor];
    self.passwordF.textColor = self.inputTextColor ?: [UIColor blackColor];
    self.passwordF.backgroundColor = self.inputBackgroundColor ?: [UIColor whiteColor];
    
    
    if (self.loginButtonTitle) {
        [self.loginButton setTitle:self.loginButtonTitle forState:UIControlStateNormal];
    }
    if (self.loginButtonTitleColor) {
        [self.loginButton setTitleColor:self.loginButtonTitleColor forState:UIControlStateNormal];
    }
    if (self.loginButtonTitleFontSize > 0.1) {
        self.loginButton.titleLabel.font = [UIFont systemFontOfSize:self.loginButtonTitleFontSize];
    }
    if (self.loginButtonBackgroundColor) {
        [self.loginButton setBackgroundColor:self.loginButtonBackgroundColor];
    }
    
    if (self.secureTextEntryOnImage) {
        [self.entryButton setImage:self.secureTextEntryOnImage forState:UIControlStateNormal];
    }
    if (self.secureTextEntryOffImage) {
        [self.entryButton setImage:self.secureTextEntryOffImage forState:UIControlStateSelected];
    }
    
    if (self.accountInputKeyboardType != UIKeyboardTypeDefault) {
        self.phoneF.keyboardType = self.accountInputKeyboardType;
    }
    
    if (self.inputTextFontSize > 0.1) {
        self.phoneF.font = [UIFont systemFontOfSize:self.inputTextFontSize];
        self.passwordF.font = [UIFont systemFontOfSize:self.inputTextFontSize];
    }
}

/**
 *  注册通知
 */
- (void)registerNotification
{
    /*⏰ ----- 监听键盘的通知 ----- ⏰*/
    
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:nil];
    
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(keyboardWillHide:)
                                name:UIKeyboardWillHideNotification
                              object:nil];
}

/**
 *  移除通知
 */
- (void)removeNotification
{
    /*⏰ ----- 移除键盘的通知 ----- ⏰*/
    [NOTIFICATION_CENTER removeObserver:self
                                   name:UIKeyboardWillShowNotification
                                 object:nil];
    
    [NOTIFICATION_CENTER removeObserver:self
                                   name:UIKeyboardWillHideNotification
                                 object:nil];
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击 view 结束编辑
 */
- (void)clickViewAction
{
    // 点击 view 结束编辑
    [self.inputsContainerView endEditing:YES];
}

/**
 *  点击了眼睛：未选中：密码不可见； 选中：密码可见
 */
- (IBAction)didClickEyeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    self.passwordF.secureTextEntry = !sender.isSelected;
}

/**
 *  点击了登录按钮的回调
 */
- (IBAction)didClickLoginButtonAction:(id)sender
{
    if (self.clickLoginCallback) {
        self.clickLoginCallback(self, self.phoneF.text, self.passwordF.text);
    }
}

#pragma mark - 键盘弹出检测

/**
 *  键盘即将出现
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    
    NSTimeInterval duration = [[keyboardInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    @weakify(self);
    [UIView animateWithDuration:duration animations:^{
        @strongify(self);
        
        self.inputsContainerView.transform = CGAffineTransformMakeTranslation(0, -60);
        self.logoBgView.transform  = CGAffineTransformMakeScale(0.7, 0.7);
    }];
}

/**
 *  键盘即将消失
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    
    NSTimeInterval duration = [[keyboardInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    @weakify(self);
    [UIView animateWithDuration:duration animations:^{
        @strongify(self);
        
        self.inputsContainerView.transform = CGAffineTransformIdentity;
        self.logoBgView.transform  = CGAffineTransformIdentity;
    }];
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
 *  出现
 */
- (void)show
{
    /*⏰ ----- 输入框出现的动画 ----- ⏰*/
    [self.inputsContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        
        CGFloat delay = idx * kDelayRatio + kDelayRatio;
        
        [UIView animateWithDuration:1.0 delay:delay usingSpringWithDamping:.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            view.transform = CGAffineTransformIdentity;
            
        } completion:NULL];
    }];
    
    
    /** 👀 LOGO出现的动画 👀 */
    self.logoBgView.alpha = 0;
    
    @weakify(self);
    [UIView animateWithDuration:1.5 animations:^{
        @strongify(self);
        self.logoBgView.alpha = 1;
    }];
}

#pragma mark - 🔓 👀 Public Method 👀

/**
 *  隐藏
 */
- (void)hide:(void (^)(void))complete
{
    /*⏰ ----- 输入框消失的动画 ----- ⏰*/
    NSInteger count = self.inputsContainerView.subviews.count;
    [self.inputsContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat delay = idx * kDelayRatio + kDelayRatio;
        
        [UIView animateWithDuration:1.0 delay:delay usingSpringWithDamping:.6f initialSpringVelocity:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
            
        } completion:^(BOOL finished) {
            /// 动画结束
            if (finished && (idx == count-1) && complete) {
                complete();
            }
        }];
    }];
    
    /** 👀 LOGO消失的动画 👀 */
    @weakify(self);
    [UIView animateWithDuration:1.5 animations:^{
        @strongify(self);
        self.logoBgView.alpha = 0;
    }];
}

+ (instancetype)loginViewController
{
    /// 获取当前 Bundle
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    /// 获取 storyboard 所在的 Bundle 路径
    NSString *bundlePath = [currentBundle pathForResource:@"XCLoginUI" ofType:@"bundle"];
    /// 加载 storyboard
    NSBundle *storyboardBundle = [NSBundle bundleWithPath:bundlePath];
    
    /// 加载 storyboard 中的控制器
    return [[UIStoryboard storyboardWithName:@"XCLoginUI"
                                      bundle:storyboardBundle] instantiateInitialViewController];
}

@end
