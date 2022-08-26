//
//  MCBaseUtils.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCBaseUtils_h
#define MCBaseUtils_h



#ifdef __OBJC__


/* 宏定义 */

#if __has_include("MCMacro.h")
#import "MCMacro.h"
#endif

#if __has_include("MCDEBug.h")
#import "MCDEBug.h"
#endif

#if __has_include("MCCheckNullObj.h")
#import "MCCheckNullObj.h"
#endif

#if __has_include("MCMarcroObj.h")
#import "MCMarcroObj.h"
#endif

#if __has_include("MCLocalData.h")
#import "MCLocalData.h"
#endif

#if __has_include("MCAddPropertyCategory.h")
#import "MCAddPropertyCategory.h"
#endif

#if __has_include("MCStringWeak.h")
#import "MCStringWeak.h"
#endif

#if __has_include("MCColorMacro.h")
#import "MCColorMacro.h"
#endif

/*  分类  */
#if __has_include("MCCategory.h")
#import "MCCategory.h"
#endif
/* UI */

#if __has_include("XKEmptyPlaceView.h")
#import "XKEmptyPlaceView.h"
#endif

#if __has_include("MCMacroDefine.h")
#import "MCMacroDefine.h"
#endif

#if __has_include("MCCustomKVO")
#import "MCCustomKVO.h"
#endif


#if __has_include("MCRuntime.h")
#import "MCRuntime.h"
#endif


#if __has_include("NSArray+MCError.h")
#import "NSArray+MCError.h"
#endif


#if __has_include("NSMutableArray+MCError.h")
#import "NSMutableArray+MCError.h"
#endif


#if __has_include("NSDictionary+MCError.h")
#import "NSDictionary+MCError.h"
#endif

#if __has_include("NSMutableDictionary+MCError.h")
#import "NSMutableDictionary+MCError.h"
#endif


#if __has_include("NSMutableString+MCError.h")
#import "NSMutableString+MCError.h"
#endif


#if __has_include("UIImage+MCFileName.h")
#import "UIImage+MCFileName.h"
#endif
 

#if __has_include("NSDictionary+MCJSON.h")
#import "NSDictionary+MCJSON.h"
#endif

#if __has_include("UIImageView+MCCornerRadius.h")
#import "UIImageView+MCCornerRadius.h"
#endif


#if __has_include("UIColor+MCHex.h")
#import "UIColor+MCHex.h"
#endif

#if __has_include("UIImage+MCColor.h")
#import "UIImage+MCColor.h"
#endif

#if __has_include("MCScreenHeightInfo.h")
#import "MCScreenHeightInfo.h"
#endif


#if __has_include("MCCustomNavigationBar.h")
#import "MCCustomNavigationBar.h"
#endif


#if __has_include("UIImage+MCGradient.h")
#import "UIImage+MCGradient.h"
#endif

#if __has_include("UIButton+MCGradient.h")
#import "UIButton+MCGradient.h"
#endif

#if __has_include("MCCommonVc.h")
#import "MCCommonVc.h"
#endif

#if __has_include("RTRootNavigationController.h")
#import "RTRootNavigationController.h"
#endif



#if __has_include("UINavigationController+MCFullScreenPopGesture.h")
#import "UINavigationController+MCFullScreenPopGesture.h"
#endif


#if __has_include("MCEmptyBaseView.h")
#import "MCEmptyBaseView.h"
#endif

#if __has_include("MCEmptyView.h")
#import "MCEmptyView.h"
#endif

#if __has_include("MCEmptyInfoView.h")
#import "MCEmptyInfoView.h"
#endif

#if __has_include("UIView+Empty.h")
#import "UIView+Empty.h"
#endif


#if __has_include(<CYLTabBarController/CYLTabBarController.h>)
#import <CYLTabBarController/CYLTabBarController.h>
#else
#import "CYLTabBarController.h"
#endif


#if __has_include("MCSkin.h")
#import "MCSkin.h"
#endif

#endif

#endif /* MCBaseUtils_h */
