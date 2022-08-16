//
//  UIColor+MCHex.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/24.
//

#import "UIColor+MCHex.h"

@implementation UIColor (MCHex)



///随机
+ (UIColor *)mc_randomColor{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0];
    return randColor;
}

/// 16进制颜色
/// @param string string description
/// @param alpha alpha description
+ (UIColor *)mc_hexWithString:(NSString *)string withAlpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6){
        
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

/// 16进制
/// @param string string description
+ (UIColor *)mc_hexWithString:(NSString *)string {
    return [self mc_hexWithString:string withAlpha:1.0f];
}

@end
