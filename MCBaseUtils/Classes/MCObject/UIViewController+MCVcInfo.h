//
//  UIViewController+MCVcInfo.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MCVcInfo)

- (void)mc_toLastViewController;

+ (UIViewController *)mc_currentViewController;

+ (UIViewController *)mc_currentViewControllerFrom:(UIViewController*)viewController;
@end

NS_ASSUME_NONNULL_END
