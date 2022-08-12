//
//  MCLocalData.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCLocalData_h
#define MCLocalData_h



#ifdef __OBJC__


//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}


/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}




#endif


#endif /* MCLocalData_h */
