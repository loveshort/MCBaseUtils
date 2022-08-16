//
//  UIView+MCFrame.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/24.
//

#import "UIView+MCFrame.h"

@implementation UIView (MCFrame)


- (void)setMc_size:(CGSize)ly_size
{
    CGRect frame = self.frame;
    frame.size = ly_size;
    self.frame = frame;
}
- (CGSize)mc_size
{
    return self.frame.size;
}


- (CGFloat)mc_x{
    return self.frame.origin.x;
}

- (void)setMc_x:(CGFloat)x{
    self.frame = CGRectMake(x, self.mc_y, self.mc_width, self.mc_height);
}

- (CGFloat)mc_y{
    return self.frame.origin.y;
}

- (void)setMc_y:(CGFloat)y{
    self.frame = CGRectMake(self.mc_x, y, self.mc_width, self.mc_height);
}

- (CGFloat)mc_width{
    return self.frame.size.width;
}

- (void)setMc_width:(CGFloat)width{
    self.frame = CGRectMake(self.mc_x, self.mc_y, width, self.mc_height);
}

- (CGFloat)mc_height{
    return self.frame.size.height;
}

- (void)setMc_height:(CGFloat)height{
    self.frame = CGRectMake(self.mc_x, self.mc_y, self.mc_width, height);
}

/** 中心的x坐标 */
- (CGFloat)mc_centerX{
    return self.center.x;
}

/** 中心的y坐标 */
- (void)setMc_centerX:(CGFloat)x{;
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)mc_centerY{
    return self.center.y;
}

- (void)setMc_centerY:(CGFloat)y{
    self.center = CGPointMake(self.center.x, y);
}

/** 获取最大x */
- (CGFloat)mc_maxX{
    return self.mc_x + self.mc_width;
}
/** 获取最小x */
- (CGFloat)mc_minX{
    return self.mc_x;
}

/** 获取最大y */
- (CGFloat)mc_maxY{
    return self.mc_y + self.mc_height;
}
/** 获取最小y */
- (CGFloat)mc_minY{
    return self.mc_y;
}

/** 设置最小x,相当于设置x */
- (void)mc_setMinX:(CGFloat)minX{
    self.mc_x = minX;
}

/** 设置最大x */
- (void)mc_setMaxX:(CGFloat)maxX{
    self.mc_x = maxX - self.mc_width;
}

/** 设置最小y,相当于设置y */
- (void)mc_setMinY:(CGFloat)minY{
    self.mc_y = minY;
}

/** 设置最大y */
- (void)mc_setMaxY:(CGFloat)maxY{
    self.mc_y = maxY - self.mc_height;
}


@end
