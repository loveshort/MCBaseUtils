//
//  MCMacro.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCMacro_h
#define MCMacro_h


#ifdef __OBJC__

 
//----------------------ABOUT SCREEN & SIZE 屏幕&尺寸 ----------------------------
 
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
 

/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])



//----------------------ABOUT SYSTYM & VERSION 系统与版本 ----------------------------
//Get the OS version.       判断操作系统版本

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//judge the simulator or hardware device        判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


/** 获取系统版本 */
#define iOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
/* 当前系统版本-iOS */
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

/** 是否为iOS16 */
#define iOS16 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 16.0) ? YES : NO)

/** 是否为iOS15 */
#define iOS15 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 15.0) ? YES : NO)

/** 是否为iOS14 */
#define iOS14 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 14.0) ? YES : NO)

/** 是否为iOS13 */
#define iOS13 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) ? YES : NO)

/** 获取当前语言 */
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])








//----------------------ABOUT IMAGE 图片 ----------------------------

//LOAD LOCAL IMAGE FILE     读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]


//DEFINE IMAGE      定义UIImage对象//    imgView.image = IMAGE(@"Default.png");

#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//DEFINE IMAGE      定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//BETTER USER THE FIRST TWO WAY, IT PERFORM WELL. 优先使用前两种宏定义,性能高于后面.




//----------------------SOMETHING ELSE 其他 ----------------------------

#define intToStr(S)    [NSString stringWithFormat:@"%d",S]





#define PLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"] //edit the plist

#define TableViewCellDequeueInit(__INDETIFIER__) [tableView dequeueReusableCellWithIdentifier:(__INDETIFIER__)];

#define TableViewCellDequeue(__CELL__,__CELLCLASS__,__INDETIFIER__) \
{\
if (__CELL__ == nil) {\
__CELL__ = [[__CELLCLASS__ alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:__INDETIFIER__];\
}\
}




//GCD
#define GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)



/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */

#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

 
/**
 *  app version
 */
#define APP_SHORT_VERSION               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUNDLE_VERSION              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION                     [NSString stringWithFormat:@"%@ (%@)", APP_SHORT_VERSION, APP_BUNDLE_VERSION]
#define APP_BUNDLE_IDENTIFIER           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
/**
 * 1. if (NSOrderedAscending != COMPARE_VERSION(v1,v2))  { //v1 >= v2 }
 * 2. if (NSOrderedDescending == COMPARE_VERSION(v1,v2)) { //v1 > v2 }
 * 3. if (NSOrderedAscending == COMPARE_VERSION(v1,v2))  { //v1 < v2 }
 */
#define COMPARE_VERSION(v1,v2)          [v1 compare:v2 options:NSNumericSearch]
#define COMPARE_CURRENT_VERSION(v)      COMPARE_VERSION(APP_SHORT_VERSION,v)



/**
 *  register & post notification
 */
//add
#define ADD_OBSERVER_WITH_OBJECT(_selector, _name, _object) \
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:_object])
#define ADD_OBSERVER(_selector,_name) \
ADD_OBSERVER_WITH_OBJECT(_selector, _name, nil)
//post
#define POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, _info) \
        ([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object userInfo:(_info)])
#define POST_NOTIFICATION(_name) \
        POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, nil)
#define POST_NOTIFICATION_WITH_OBJECT(_name, _object) \
        POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, nil)
#define POST_NOTIFICATION_WITH_INFO(_name, _info) \
        POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, _info)
//remove
#define REMOVE_OBSERVER(_name) \
        ([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
#define REMOVE_ALL_OBSERVERS(_self) \
        ([[NSNotificationCenter defaultCenter] removeObserver:_self])







#endif


#endif /* MCMacro_h */
