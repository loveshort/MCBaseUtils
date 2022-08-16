//
//  UIImage+MCColor.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import "UIImage+MCColor.h"

@implementation UIImage (MCColor)



-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color
{
    return [self mc_updateImageWithTintColor:color alpha:1.0f];
}
-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self mc_updateImageWithTintColor:color alpha:alpha rect:rect];
}
-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect
{
    return [self mc_updateImageWithTintColor:color alpha:1.0f rect:rect];
}
-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets
{
    return [self mc_updateImageWithTintColor:color alpha:1.0f insets:insets];
}
-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self mc_updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 全能初始化方法
-(UIImage *)mc_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 启动图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    // 获取图片上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(contextRef, alpha);
    // 设置混合模式
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    // 填充当前rect
    CGContextFillRect(contextRef, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


@end
