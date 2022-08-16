//
//  MCNavigationBar.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCScreenHeightInfo : UIView

+ (BOOL)mc_isIphoneX;

+ (CGFloat)mc_navBarBottom;

+ (CGFloat)mc_tabBarHeight;

+ (CGFloat)mc_screenWidth;

+ (CGFloat)mc_screenHeight;

//设备的状态栏高度, 不管状态栏是否显示
+ (CGFloat)mc_defaultStatusBarHeight;

//整个导航栏高度
+ (CGFloat)mc_defaultNavBarBottom;

@end


#pragma mark - Default
@interface MCScreenHeightInfo (MCDefault)

/// 局部使用该库       待开发
//+ (void)mc_local;
/// 广泛使用该库       default 暂时是默认， mc_local 完成后，mc_local就会变成默认
+ (void)mc_widely;

/// 局部使用该库时，设置需要用到的控制器      待开发
//+ (void)mc_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)mc_setBlacklist:(NSArray<NSString *> *)list;

/** set default barTintColor of UINavigationBar */
+ (void)mc_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: mc_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//+ (void)mc_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)mc_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)mc_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)mc_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)mc_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (WRAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)mc_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)mc_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)mc_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (WRAddition)

- (UIImage *)mc_navBarBackgroundImage;

- (void)mc_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)mc_navBarBarTintColor;

- (void)mc_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)mc_navBarBackgroundAlpha;

- (void)mc_setNavBarTintColor:(UIColor *)color;
- (UIColor *)mc_navBarTintColor;

- (void)mc_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)mc_navBarTitleColor;

- (void)mc_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)mc_statusBarStyle;

- (void)mc_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)mc_navBarShadowImageHidden;


@end

NS_ASSUME_NONNULL_END
