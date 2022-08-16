//
//  MCDefineFile.h
//  Pods
//
//  Created by mac on 2020/8/7.
//

#ifndef MCDefineFile_h
#define MCDefineFile_h



#ifdef DEBUG

#define mc_is_debug YES

#else

#define mc_is_debug NO

#endif



#ifdef DEBUG

#define MCLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])

#else

#define MCLog(...)

#endif


#pragma mark - nil or NULL 空判断

//是否为空或是[NSNull null]
#define mc_is_notNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define mc_is_nilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define mc_is_strEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define mc_is_arrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//判断空值问题
#define mc_is_objectValid(obj) (obj&&((NSNull *)obj!=[NSNull null]))

//判断空字符串
#define mc_is_stringNotEmpty(obj) (obj&&((NSNull *)obj!=[NSNull null]) && [obj isKindOfClass:[NSString class]] && [obj length] > 0)

//判断数组
#define mc_is_arrayNotEmpty(obj) (obj&&((NSNull *)obj!=[NSNull null]) && [obj isKindOfClass:[NSArray class]] && [obj count] > 0)

//判断对象为空
#define mc_is_objectTypeValid(obj,type) (obj&&((NSNull *)obj!=[NSNull null])&&[obj isKindOfClass:type])

//判断字典为空
#define mc_is_validNSDictionary(obj) (obj&&((NSNull *)obj!=[NSNull null]) && [obj isKindOfClass:[NSDictionary class]])

#pragma mark - Weak Strong

#undef mc_weakSelf
#define mc_weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#undef mc_strongSelf
#define mc_strongSelf(strongSelf)  __strong __typeof(&*self)strongSelf = weakSelf;


#endif /* MCDefineFile_h */
