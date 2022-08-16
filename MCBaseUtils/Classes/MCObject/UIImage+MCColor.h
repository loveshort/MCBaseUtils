//
//  UIImage+MCColor.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



//通过颜色值生成图片


@interface UIImage (MCColor)

-(UIImage * )mc_updateImageWithTintColor:(UIColor * )color;

-(UIImage * )mc_updateImageWithTintColor:(UIColor  *)color alpha:(CGFloat)alpha;

-(UIImage * )mc_updateImageWithTintColor:(UIColor  * )color rect:(CGRect)rect;

-(UIImage * )mc_updateImageWithTintColor:(UIColor  * )color insets:(UIEdgeInsets)insets;

-(UIImage * )mc_updateImageWithTintColor:(UIColor  * )color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;

-(UIImage * )mc_updateImageWithTintColor:(UIColor  *)color alpha:(CGFloat)alpha rect:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
