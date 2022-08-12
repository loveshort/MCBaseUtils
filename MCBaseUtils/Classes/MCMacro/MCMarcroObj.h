//
//  MCMarcroObj.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCMarcroObj_h
#define MCMarcroObj_h

//实例化---对象简写方式

#ifdef __OBJC__

// rootViewControlelr ---windonw
#define KEYWINDOW [UIApplication sharedApplication].keyWindow

//单例化 一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}




// random int [from,to]
#define RANDOM_INT(from,to)             ((int)((from) + arc4random() % ((to)-(from) + 1)))

//XIB 实例化
#define VIEW_IN_XIB(x, i)               [[[NSBundle mainBundle] loadNibNamed:(x) owner:nil options:nil] objectAtIndex:(i)]
//XIB 实例化
#define FIRST_VIEW_IN_XIB(x)            VIEW_IN_XIB(x, 0)
 

//控制器 实例化
#define CREATE_VIEW_CONTROLLER(x)              [[NSClassFromString(x) alloc] initWithNibName:x bundle:nil]

//导航栏 实例化
#define CREATE_NAVIGATION_VIEW_CONTROLLER(x)   [[UINavigationController alloc]initWithRootViewController:CREATE_VIEW_CONTROLLER(x)]


#endif

#endif /* MCMarcroObj_h */
