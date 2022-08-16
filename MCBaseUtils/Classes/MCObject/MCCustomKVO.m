//
//  MCCustomKVO.m
//  MCOCModule
//
//  Created by mingci on 2021/10/15.
//

#import "MCCustomKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>


static NSString *const kMCKVOPrefix = @"MCKVONoifying_";

static NSString *const kMCKVOAssiociateKey = @"kMCKVO_AssiociateKey";


#pragma mark - 从get方法获取set方法的名称 key ===>>> setKey:
static NSString *setterForGetter(NSString *getter) {
    if (getter.length <= 0) {
        return nil;
    }
    
    NSString *firstString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1];
    return [NSString stringWithFormat:@"set%@%@",firstString,leaveString];
}


static NSString *getterForSetter(NSString *setter){
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    NSRange range = NSMakeRange(3,setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    
    return [getter stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstString];
    
}


static void mc_setter(id self,SEL _cmd, id newValue){
    //1.消息转发:转发给父类，改变父类的值
    NSString *keyPath = getterForSetter(NSStringFromSelector(_cmd));
    
    id oldValue = [self valueForKey:keyPath];
    
    void (* mc_msgSendSuper)(void *, SEL, id) = (void *)objc_msgSendSuper;

    struct objc_super superStruct = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self)),
    };
    
    mc_msgSendSuper(&superStruct,_cmd,newValue);
    
    //1.获取观察者
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kMCKVOAssiociateKey));
    
    for (MCCustomKVO *info in observerArr) {
        if ([info.keyPath isEqualToString:keyPath]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSMutableDictionary<NSKeyValueChangeKey,id> *change = [NSMutableDictionary dictionaryWithCapacity:1];
                //对新、旧值进行处理
                if (info.options & MCKeyValueObservingOptionNew) {
                    [change setObject:newValue forKey:NSKeyValueChangeNewKey];
                }
                
                if (info.options & MCKeyValueObservingOptionOld) {
                    if (oldValue) {
                        [change setObject:oldValue forKey:NSKeyValueChangeOldKey];
                    }
                    else {
                        [change setObject:@"" forKey:NSKeyValueChangeOldKey];
                    }
                }
                
                //发送消息给观察者
                SEL observerSEL = @selector(mc_observeValueForKeyPath:ofObject:change:context:);
                ((void (*)(id,SEL, NSString *, id, NSDictionary *,void *)) objc_msgSend)(info.observer,observerSEL,keyPath,self,change,NULL);
            });
        }
    }
    
}



@implementation MCCustomKVO
 



- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(MCKeyValueObservingOptions)options{
    self = [super init];
    if (self) {
        self.observer = observer;
        self.keyPath = keyPath;
        self.options = options;
    }
    return self;
}

- (void)mc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(MCKeyValueObservingOptions)options context:(nullable void *)context{
    
    //1.验证是否存在Setter方法：不让实例进来
    [self judgeSetterMethodFromKeyPath:keyPath];
    
    //2.动态生成子类
    Class newClass = [self createChildClassWithKeyPath:keyPath];
    
    //3.iSA的指向：MCKVONotifying_MC
    object_setClass(self, newClass);
    
    //4.保存观察者信息
    [self mc_addInfoWithObserver:observer forKeyPath:keyPath options:options];
}


- (void)judgeSetterMethodFromKeyPath:(NSString *)keyPath{
    Class superClass = object_getClass(self);
    
    SEL setterSeletor = NSSelectorFromString(setterForGetter(keyPath));
    
    Method setterMethod = class_getInstanceMethod(superClass, setterSeletor);
    
    if (!setterMethod) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"当前%@不存在setter方法",keyPath] userInfo:nil];
    }
    
}


#pragma mark - 动态生成子类

Class mc_class(id self,SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}


- (Class)createChildClassWithKeyPath:(NSString *)keyPath{
    
    NSString *oldClassName = NSStringFromClass([self class]);
    
    NSString *newClassName = [NSString stringWithFormat:@"%@%@",kMCKVOPrefix,oldClassName];
    
    Class newClass = NSClassFromString(newClassName);
    
    //防止重复创建生成新类
    if (newClass) {
        return newClass;
    }
    
    /*
     如果内存不存在，创建生成
     参数一：父类
     参数二：新类的名字
     参数三：新类的开辟的额外空间
     */
    //2.1:申请类
    newClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    //注册类
    objc_registerClassPair(newClass);
    
    //添加class:class的指向是MCCustomKVO
    
    SEL classSEL = NSSelectorFromString(@"class");
    
    Method classMethod = class_getInstanceMethod([self class], classSEL);
    
    const char *classTypes = method_getTypeEncoding(classMethod);
    
    class_addMethod(newClass, classSEL, (IMP)mc_class, classTypes);
    
    //添加setter
    SEL setterSEL = NSSelectorFromString(setterForGetter(keyPath));
    
    Method setterMethod = class_getInstanceMethod([self class], setterSEL);
    
    const char *setterTypes = method_getTypeEncoding(setterMethod);
    
    class_addMethod(newClass, setterSEL, (IMP)mc_setter, setterTypes);
    
    return newClass;
    
}




- (void)mc_addInfoWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(MCKeyValueObservingOptions)options{
    MCCustomKVO *info = [[MCCustomKVO alloc] initWithObserver:observer forKeyPath:keyPath options:options];
    
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kMCKVOAssiociateKey));
    if (!observerArr) {
        observerArr = [NSMutableArray arrayWithCapacity:1];
        [observerArr addObject:info];
        objc_setAssociatedObject(self, (__bridge const void *_Nonnull)(kMCKVOAssiociateKey), observerArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - 移除
- (void)mc_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kMCKVOAssiociateKey));
        if (observerArr.count<=0) {
            return;
        }
        
        for (MCCustomKVO *info in observerArr) {
            if ([info.keyPath isEqualToString:keyPath]) {
                [observerArr removeObject:info];
                objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kMCKVOAssiociateKey), observerArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                break;
            }
        }

        if (observerArr.count<=0) {
            // 指回给父类
            Class superClass = [self class];
            object_setClass(self, superClass);
        }
}

@end
