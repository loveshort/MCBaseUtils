//
//  MCRuntime.h
//  MCBaseUtils
//
//  Created by mingci on 2021/11/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN

@interface MCRuntime : NSObject


@end


#pragma mark - Method

CG_INLINE BOOL
mc_overrideSuperclass(Class targetClass, SEL targetSelector) {
    Method method = class_getInstanceMethod(targetClass, targetSelector);
    if (!method) {
        return NO;
    }
    
    Method methodOfSuperclass = class_getInstanceMethod(class_getSuperclass(targetClass), targetSelector);
    if (!methodOfSuperclass) {
        return YES;
    }
    return method != methodOfSuperclass;
}



CG_INLINE BOOL
mc_exchangeImplementationInTwoClasses(Class _fromClass, SEL _orginSelector, Class _toClass, SEL _swizzledSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    
    Method oriMethod = class_getInstanceMethod(_fromClass, _orginSelector);
    Method swizzledMethod = class_getInstanceMethod(_toClass, _swizzledSelector);
    
    if (!swizzledMethod) {
        return NO;
    }
    
    BOOL isAddedMethod = class_addMethod(_fromClass, _orginSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAddedMethod) {
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?:imp_implementationWithBlock(^(id selfObject){});
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _swizzledSelector, oriMethodIMP, oriMethodTypeEncoding);
    }else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
    return YES;
}



CG_INLINE BOOL
mc_exchangeImplementations(Class _class, SEL _originSelector, SEL _swizzledSelctor) {
    return mc_exchangeImplementationInTwoClasses(_class, _originSelector, _class, _swizzledSelctor);
}


NS_ASSUME_NONNULL_END
