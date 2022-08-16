//
//  UIImage+MCFileName.h
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MCFileName)

+ (UIImage *)mc_imageWithFileName:(NSString *)name;

+ (UIImage *)mc_imageWithFileName:(NSString *)name withBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
