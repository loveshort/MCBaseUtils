//
//  UIImage+MCFileName.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import "UIImage+MCFileName.h"

@implementation UIImage (MCFileName)


+ (UIImage *)mc_imageWithFileName:(NSString *)name{
    return [self mc_imageWithFileName:name withBundle:[NSBundle mainBundle]];
}


+ (UIImage *)mc_imageWithFileName:(NSString *)name withBundle:(NSBundle *)bundle {
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        name = [name substringToIndex:(name.length - (extension.length + 1))];
    }
    
    
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    return nil;
    
}

@end
