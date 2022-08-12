//
//  MCColorMacro.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCColorMacro_h
#define MCColorMacro_h

#ifdef __OBJC__

//----------------------ABOUT COLOR 颜色相关 ----------------------------

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define kClearColor [UIColor clearColor]


#define COLOR_BLUE_             UIColorFromRGB(0x41CEF2)
#define COLOR_GRAY_             UIColorFromRGB(0xababab) //171
#define COLOR_333               UIColorFromRGB(0x333333) //51
#define COLOR_666               UIColorFromRGB(0x666666) //102
#define COLOR_888               UIColorFromRGB(0x888888) //136
#define COLOR_999               UIColorFromRGB(0x999999) //153
#define COLOR_PLACEHOLD_        UIColorFromRGB(0xc5c5c5) //197
#define COLOR_RED_              UIColorFromRGB(0xff5400) //红色
#define COLOR_GREEN_            UIColorFromRGB(0x31d8ab)//绿色
#define COLOR_YELLOW_           UIColorFromRGB(0xffa200)//黄色
#define COLOR_SEPARATE_LINE     UIColorFromRGB(0xC8C8C8)//200
#define COLOR_LIGHTGRAY         COLOR(200, 200, 200, 0.4)//淡灰色

#define MAX_WIDTH_10        (SCREEN_WIDTH-20)
#define MAX_WIDTH_15        (SCREEN_WIDTH-30)


#endif

#endif /* MCColorMacro_h */
