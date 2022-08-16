//
//  UIView+MCFrame.h
//  MCBaseUtils
//
//  Created by mingci on 2021/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MCFrame)

- (CGSize)mc_size;
- (void)setMc_size:(CGSize)size;

// 左上角x坐标
- (CGFloat)mc_x;
- (void)setMc_x:(CGFloat)x;

// 左上角y坐标
- (CGFloat)mc_y;
- (void)setMc_y:(CGFloat)y;

// 宽
- (CGFloat)mc_width;
- (void)setMc_width:(CGFloat)width;

// 高
- (CGFloat)mc_height;
- (void)setMc_height:(CGFloat)height;

// 中心点x
- (CGFloat)mc_centerX;
- (void)setMc_centerX:(CGFloat)x;

// 中心点y
- (CGFloat)mc_centerY;
- (void)setMc_centerY:(CGFloat)y;

/** 获取最大x */
- (CGFloat)mc_maxX;
/** 获取最小x */
- (CGFloat)mc_minX;

/** 获取最大y */
- (CGFloat)mc_maxY;
/** 获取最小y */
- (CGFloat)mc_minY;

/** 设置最小x,相当于设置x */
- (void)mc_setMinX:(CGFloat)minX;

/** 设置最大x */
- (void)mc_setMaxX:(CGFloat)maxX;

/** 设置最小y,相当于设置y */
- (void)mc_setMinY:(CGFloat)minY;

/** 设置最大y */
- (void)mc_setMaxY:(CGFloat)maxY;


@end

NS_ASSUME_NONNULL_END
