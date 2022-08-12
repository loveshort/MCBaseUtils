//
//  NSString+MCDecNumberToString.m
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#import "NSString+MCDecNumberToString.h"

@implementation NSString (MCDecNumberToString)


/// 防止掉失进度(dobule)
/// @param d double 数值类型
+ (NSString *)mc_changeDoubleToString:(double )d{
    NSString *dstr = [NSString stringWithFormat:@"%f",d];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dstr];
    return dn.stringValue;
}

/// 防止掉失精度
/// @param d 数值精度
+ (NSString *)mc_changeNumberToString:(NSNumber *)d{
    double num = [d doubleValue];
    return  [self mc_changeDoubleToString:num];
}


@end
