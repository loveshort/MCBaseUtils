//
//  MCDEBug.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCDEBug_h
#define MCDEBug_h


#ifdef __OBJC__

/* DEBUG 添加 行 */

//----------------------ABOUT PRINTING LOG 打印日志 ----------------------------
//Using dlog to print while in debug model.        调试状态下打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//Printing while in the debug model and pop an alert.       模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


/** print 打印rect,size,point */
#ifdef DEBUG
#define kLogPoint(point)    NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kLogSize(size)      NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kLogRect(rect)      NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif


#endif

#endif /* MCDEBug_h */
