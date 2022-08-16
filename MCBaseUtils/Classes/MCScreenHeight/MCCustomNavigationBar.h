//
//  MCCustomNavigationBar.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)mc_setBottomLineHidden:(BOOL)hidden;
- (void)mc_setBackgroundAlpha:(CGFloat)alpha;
- (void)mc_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)mc_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)mc_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)mc_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)mc_setLeftButtonWithImage:(UIImage *)image;
- (void)mc_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)mc_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)mc_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)mc_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)mc_setRightButtonWithImage:(UIImage *)image;
- (void)mc_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
