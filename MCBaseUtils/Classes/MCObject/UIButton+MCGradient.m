//
//  UIButton+MCGradient.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/8.
//

#import "UIButton+MCGradient.h"


@implementation UIButton (MCGradient)

- (UIButton *)mc_gradientButtonWithSize:(CGSize)btnSize withColorArray:(NSArray *)clrs withPercentAgeArray:(NSArray *)percent withGradientType:(GradientType)gradientType {
    
    UIImage *backImage = [[UIImage alloc] mc_createImageWithSize:btnSize withGradientColors:clrs withPercentAge:percent gradientType:gradientType];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return  self;
    
}

@end
