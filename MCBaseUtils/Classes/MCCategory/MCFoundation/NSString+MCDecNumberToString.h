//
//  NSString+MCDecNumberToString.h
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (MCDecNumberToString)

 
/// 防止掉失进度(dobule)
/// @param d double 数值类型
+ (NSString *)mc_changeDoubleToString:(double )d;

/// 防止掉失精度
/// @param d 数值精度
+ (NSString *)mc_changeNumberToString:(NSNumber *)d;

@end

NS_ASSUME_NONNULL_END
