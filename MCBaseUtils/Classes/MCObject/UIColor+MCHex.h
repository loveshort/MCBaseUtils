//
//  UIColor+MCHex.h
//  MCBaseUtils
//
//  Created by mingci on 2021/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



#pragma mark - UIColor

#define mc_hex(hex) [UIColor mc_hexWithString:hex]

@interface UIColor (MCHex)

///随机
+ (UIColor *)mc_randomColor;

/// 16进制颜色
/// @param string string description
/// @param alpha alpha description
+ (UIColor *)mc_hexWithString:(NSString *)string withAlpha:(CGFloat)alpha;

/// 16进制
/// @param string string description
+ (UIColor *)mc_hexWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
