//
//  MCNavigationBar.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import "MCScreenHeightInfo.h"
#import <objc/runtime.h>
#import "sys/utsname.h"


@implementation MCScreenHeightInfo


+ (BOOL)mc_isIphoneX {
    BOOL isIPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    return isIPhoneX;
}

+ (CGFloat)mc_navBarBottom {
    return [self mc_isIphoneX] ? 88 : 64;
}
+ (CGFloat)mc_tabBarHeight {
    return [self mc_isIphoneX] ? 83 : 49;
}

+ (CGFloat)mc_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)mc_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}


+ (CGFloat)mc_statusBarHeight{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}


+ (CGFloat)mc_defaultNavBarHeight{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return 50;
    }
    return 44;
}


+ (BOOL)mc_isRoundCornerScreen {
    BOOL round = NO;
    
    UIEdgeInsets inset = [MCScreenHeightInfo mc_mainWindowSafeAreaInsets];
    round = round || inset.top > 0;
    round = round || inset.right > 0;
    round = round || inset.bottom > 0;
    round = round || inset.left > 0;
    
    return round;
}

+ (UIEdgeInsets)mc_mainWindowSafeAreaInsets {
    return [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
}

//设备的状态栏高度, 不管状态栏是否显示
+ (CGFloat)mc_defaultStatusBarHeight {
    if (![MCScreenHeightInfo mc_isRoundCornerScreen]) {
        return 20;
    }else {
        UIEdgeInsets inset = [MCScreenHeightInfo mc_mainWindowSafeAreaInsets];
        UIInterfaceOrientation statusBarOrientation = UIApplication.sharedApplication.statusBarOrientation;
        switch (statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
                return inset.top;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                return inset.bottom;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                return inset.left;
                break;
            case UIInterfaceOrientationLandscapeRight:
                return inset.right;
                break;
            default:
                return inset.top;
                break;
        }
    }
    
}

//整个顶部导航的高度（状态栏加导航栏）
+ (CGFloat)mc_defaultNavBarBottom{
    CGFloat height = [MCScreenHeightInfo mc_defaultStatusBarHeight] + [MCScreenHeightInfo mc_defaultNavBarHeight];
    return height;
}

@end


//=============================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//=============================================================================

@implementation MCScreenHeightInfo (MCDefault)

static char kWRIsLocalUsedKey;
static char kWRWhiteistKey;
static char kWRBlacklistKey;

static char kWRDefaultNavBarBarTintColorKey;
static char kWRDefaultNavBarBackgroundImageKey;
static char kWRDefaultNavBarTintColorKey;
static char kWRDefaultNavBarTitleColorKey;
static char kWRDefaultStatusBarStyleKey;
static char kWRDefaultNavBarShadowImageHiddenKey;

+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &kWRIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)mc_local {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)mc_widely {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)mc_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRBlacklistKey);
    return (list != nil) ? list : nil;
}
+ (void)mc_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要更新
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要更新
    }
}

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)mc_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)mc_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kWRDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)mc_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)mc_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)mc_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)mc_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

//颜色渐变过程产生的颜色
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}

//透明度渐变过程
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


//=============================================================================
#pragma mark - UINavigationBar
//=============================================================================
@implementation UINavigationBar (WRAddition)

static char kWRBackgroundViewKey;
static char kWRBackgroundImageViewKey;
static char kWRBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kWRBackgroundViewKey);
}

- (CGRect) backgroundViewFrame {
    //根据真实的状态栏高度来计算
    CGRect barFrame = self.frame;
    CGFloat height = barFrame.origin.y + barFrame.size.height;
    return CGRectMake(0, 0, self.bounds.size.width, height);
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mc_keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mc_keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mc_statusBarFrameDidChange) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    } else {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    objc_setAssociatedObject(self, &kWRBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 解决 presentViewController后 导航栏消失问题
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
        //        view.clipsToBounds = YES;
        if (![view.subviews containsObject:self.backgroundView]) {
            [view insertSubview:self.backgroundView atIndex:0];
        }
    }
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kWRBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kWRBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kWRBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kWRBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)mc_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:[self backgroundViewFrame]];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }else {
        //当已经存在该View的时候, 更新frame, 防止frame不同步
        self.backgroundImageView.frame = [self backgroundViewFrame];
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)mc_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:[self backgroundViewFrame]];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }else {
        //当已经存在该View的时候, 更新frame, 防止frame不同步
        self.backgroundView.frame = [self backgroundViewFrame];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)mc_keyboardDidShow {
//    [self mc_restoreUIBarBackgroundFrame];
}
- (void)mc_keyboardWillHide {
//    [self mc_restoreUIBarBackgroundFrame];
}
- (void)mc_restoreUIBarBackgroundFrame {
    // IQKeyboardManager change _UIBarBackground frame sometimes, so I need restore it
    for (UIView *view in self.subviews) {
        Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
        if (_UIBarBackgroundClass != nil) {
            if ([view isKindOfClass:_UIBarBackgroundClass]) {
                view.frame = CGRectMake(0, self.frame.size.height-[MCScreenHeightInfo mc_defaultNavBarBottom], [MCScreenHeightInfo mc_screenWidth], [MCScreenHeightInfo mc_defaultNavBarBottom]);
            }
        }
    }
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)mc_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)mc_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES)
        {   // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离   CGAffineTransformMakeTranslation  平移
- (void)mc_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)mc_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
        //交换设置标题属性的方法
        for (int i = 0; i < 1;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"mc_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)mc_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self mc_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self mc_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    //当新主题没有设置title颜色时使用原有title颜色
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self mc_setTitleTextAttributes:newTitleTextAttributes];
}

/**
 当状态栏frame变化的时候, 更新backgroundView的frame
 */
- (void)mc_statusBarFrameDidChange {
    CGRect frame = [self backgroundViewFrame];
    UIView *back = [self backgroundView];
    if (back) {
        back.frame = frame;
    }
    UIView *image = [self backgroundImageView];
    if (image) {
        image.frame = frame;
    }
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (WRAddition)

static CGFloat mcPopDuration = 0.12;
static int mcPopDisplayCount = 0;
- (CGFloat)mcPopProgress {
    CGFloat all = 60 * mcPopDuration;
    int current = MIN(all, mcPopDisplayCount);
    return current / all;
}

static CGFloat mcPushDuration = 0.10;
static int mcPushDisplayCount = 0;
- (CGFloat)mcPushProgress {
    CGFloat all = 60 * mcPushDuration;
    int current = MIN(all, mcPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController mc_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar mc_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar mc_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar mc_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    //下面的判断修复了部分黑名单失效的问题, 是由TZImagePickerController的作者提出来的
    if (![MCScreenHeightInfo needUpdateNavigationBar:toVC]) {
        return;
    }
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC mc_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC mc_navBarBarTintColor];
    UIColor *newBarTintColor = [MCScreenHeightInfo middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([MCScreenHeightInfo needUpdateNavigationBar:fromVC] || [MCScreenHeightInfo needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC mc_navBarTintColor];
    UIColor *toTintColor = [toVC mc_navBarTintColor];
    UIColor *newTintColor = [MCScreenHeightInfo middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([MCScreenHeightInfo needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }
    
    // change navBarTitleColor（在mc_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC mc_navBarTitleColor];
    UIColor *toTitleColor = [toVC mc_navBarTitleColor];
    UIColor *newTitleColor = [MCScreenHeightInfo middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC mc_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC mc_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [MCScreenHeightInfo middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[5] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:),
            @selector(popViewControllerAnimated:)
        };
        
        for (int i = 0; i < 5;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"mc_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)mc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController mc_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController mc_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        mcPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:mcPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self mc_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)mc_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        mcPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:mcPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self mc_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

- (UIViewController *)mc_popViewControllerAnimated:(BOOL)animated{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        mcPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:mcPopDuration];
    [CATransaction begin];
    UIViewController *vc = [self mc_popViewControllerAnimated:animated];
    [CATransaction commit];
    return vc;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        mcPopDisplayCount += 1;
        CGFloat popProgress = [self mcPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)mc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        mcPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:mcPushDuration];
    [CATransaction begin];
    [self mc_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        mcPushDisplayCount += 1;
        CGFloat pushProgress = [self mcPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    if (@available(iOS 13.0, *)) {
        return NO;
    }
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc mc_navBarBarTintColor];
        CGFloat curAlpha = [vc mc_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)mc_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self mc_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (WRAddition)

static char kWRPushToCurrentVCFinishedKey;
static char kWRPushToNextVCFinishedKey;
static char kWRNavBarBackgroundImageKey;
static char kWRNavBarBarTintColorKey;
static char kWRNavBarBackgroundAlphaKey;
static char kWRNavBarTintColorKey;
static char kWRNavBarTitleColorKey;
static char kWRStatusBarStyleKey;
static char kWRNavBarShadowImageHiddenKey;
static char kWRCustomNavBarKey;
static char kWRSystemNavBarBarTintColorKey;
static char kWRSystemNavBarTintColorKey;
static char kWRSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)mc_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRNavBarBackgroundImageKey);
    image = (image == nil) ? [MCScreenHeightInfo defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)mc_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self mc_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mc_customNavBar];
        //  [navBar mc_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kWRNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)mc_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarBarTintColorKey);
}
- (void)mc_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)mc_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarBarTintColorKey);
    if (![MCScreenHeightInfo needUpdateNavigationBar:self]) {
        if ([self mc_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self mc_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [MCScreenHeightInfo defaultNavBarBarTintColor];
}
- (void)mc_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mc_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mc_customNavBar];
        //  [navBar mc_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)mc_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kWRNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [MCScreenHeightInfo defaultNavBarBackgroundAlpha];
}
- (void)mc_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kWRNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mc_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mc_customNavBar];
        //  [navBar mc_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)mc_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTintColorKey);
}
- (void)mc_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)mc_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTintColorKey);
    if (![MCScreenHeightInfo needUpdateNavigationBar:self]) {
        if ([self mc_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self mc_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [MCScreenHeightInfo defaultNavBarTintColor];
}
- (void)mc_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mc_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mc_customNavBar];
        //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)mc_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTitleColorKey);
}
- (void)mc_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)mc_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTitleColorKey);
    if (![MCScreenHeightInfo needUpdateNavigationBar:self]) {
        if ([self mc_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self mc_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [MCScreenHeightInfo defaultNavBarTitleColor];
}
- (void)mc_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mc_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mc_customNavBar];
        //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)mc_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [MCScreenHeightInfo defaultStatusBarStyle];
}
- (void)mc_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)mc_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)mc_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [MCScreenHeightInfo defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)mc_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kWRCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)mc_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kWRCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"mc_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)mc_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![MCScreenHeightInfo needUpdateNavigationBar:self]) {
            if ([self mc_systemNavBarBarTintColor] == nil) {
                [self mc_setSystemNavBarBarTintColor:[self mc_navBarBarTintColor]];
            }
            if ([self mc_systemNavBarTintColor] == nil) {
                [self mc_setSystemNavBarTintColor:[self mc_navBarTintColor]];
            }
            if ([self mc_systemNavBarTitleColor] == nil) {
                [self mc_setSystemNavBarTitleColor:[self mc_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self mc_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self mc_navBarTitleColor]];
    }
    [self mc_viewWillAppear:animated];
}

- (void)mc_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self mc_viewWillDisappear:animated];
}

- (void)mc_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self mc_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([MCScreenHeightInfo needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self mc_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self mc_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self mc_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self mc_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self mc_navBarShadowImageHidden]];
    }
    [self mc_viewDidAppear:animated];
}

- (void)mc_viewDidDisappear:(BOOL)animated {
    if (![MCScreenHeightInfo needUpdateNavigationBar:self] && !self.navigationController) {
        [self mc_setSystemNavBarBarTintColor:nil];
        [self mc_setSystemNavBarTintColor:nil];
        [self mc_setSystemNavBarTitleColor:nil];
    }
    [self mc_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}


@end
