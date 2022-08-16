//
//  UIButton+MCGradient.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/8.
//

#import <UIKit/UIKit.h>
#import "UIImage+MCGradient.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MCGradient)

- (UIButton *)mc_gradientButtonWithSize:(CGSize)btnSize withColorArray:(NSArray *)clrs withPercentAgeArray:(NSArray *)percent withGradientType:(GradientType)gradientType;

@end

NS_ASSUME_NONNULL_END
