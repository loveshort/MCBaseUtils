//
//  UIImage+MCGradient.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, GradientType) {
    GradientFromTopToBottom = 1,  //从上到下
    GradientFromLeftToRight, //从左到右
    GradientFromLeftTopToRightBottom, //从左上到右下
    GradientFromLeftBottomToRightTop //从左下到右上
};

@interface UIImage (MCGradient)

- (UIImage *)mc_createImageWithSize:(CGSize)imageSize withGradientColors:(NSArray *)colorArr withPercentAge:(NSArray *)percents gradientType:(GradientType)gradintType;


@end

NS_ASSUME_NONNULL_END
