//
//  MCAddPropertyCategory.h
//  MCBaseUtils
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#ifndef MCAddPropertyCategory_h
#define MCAddPropertyCategory_h


#ifdef __OBJC__


/**
 * usage:
 *   @interface NSObject (MyAdd)
 *       @property (nonatomic, assign) BOOL isError;
 *   @end
 *
 *   #import <objc/runtime.h>
 *   @implementation NSObject (MyAdd)
 *       DYNAMIC_PROPERTY_BOOL(isError, setIsError)
 *   @end
 */
#ifndef DYNAMIC_PROPERTY_BOOL
    #define DYNAMIC_PROPERTY_BOOL(_getter_, _setter_) \
            - (void)_setter_ : (BOOL)value { \
                NSNumber *number = [NSNumber numberWithBool:value]; \
                [self willChangeValueForKey:@#_getter_]; \
                objc_setAssociatedObject(self, _cmd, number, OBJC_ASSOCIATION_RETAIN); \
                [self didChangeValueForKey:@#_getter_]; \
            } \
            - (BOOL)_getter_ { \
                NSNumber *number = objc_getAssociatedObject(self, @selector(_setter_:)); \
                return [number boolValue]; \
            }
#endif

/**
 * usage:
 *   @interface NSObject (MyAdd)
 *       @property (nonatomic, retain) UIColor *myColor;
 *   @end
 *
 *   #import <objc/runtime.h>
 *   @implementation NSObject (MyAdd)
 *       DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, UIColor *)
 *   @end
 */
#ifndef DYNAMIC_PROPERTY_OBJECT
    #define DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _type_) \
            - (void)_setter_ : (_type_)object { \
                [self willChangeValueForKey:@#_getter_]; \
                objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_RETAIN); \
                [self didChangeValueForKey:@#_getter_]; \
            } \
            - (_type_)_getter_ { \
                return objc_getAssociatedObject(self, @selector(_setter_:)); \
            }
#endif


/**
 * usage:
 *   @interface NSObject (MyAdd)
 *       @property (nonatomic, retain) CGPoint myPoint;
 *   @end
 *
 *   #import <objc/runtime.h>
 *   @implementation NSObject (MyAdd)
 *       DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
 *   @end
 */
#ifndef DYNAMIC_PROPERTY_CTYPE
    #define DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
            - (void)_setter_ : (_type_)object { \
                [self willChangeValueForKey:@#_getter_]; \
                NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
                objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
                [self didChangeValueForKey:@#_getter_]; \
            } \
            - (_type_)_getter_ { \
                _type_ cValue = { 0 }; \
                NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
                [value getValue:&cValue]; \
                return cValue; \
            }
#endif


#endif

#endif /* MCAddPropertyCategory_h */
