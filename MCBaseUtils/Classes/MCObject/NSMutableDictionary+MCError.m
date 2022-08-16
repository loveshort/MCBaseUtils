//
//  NSMutableDictionary+MCError.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/11.
//

#import "NSMutableDictionary+MCError.h"
#import "MCRuntime.h"


@implementation NSMutableDictionary (MCError)


#ifdef DEBUG



#else

+ (void)load {
    
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *tmpSwizledRemoveStr = @"mcMutable_removeObjectForKey:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSDictionaryM"), NSSelectorFromString(tmpRemoveStr), NSSelectorFromString(tmpSwizledRemoveStr));
    
        
        //替换setObject:forKey:
        
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *tmpSwizzledSetStr = @"mcMutable_setObject:forKey:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSDictionaryM"), NSSelectorFromString(tmpSetStr), NSSelectorFromString(tmpSwizzledSetStr));
    
    });
}


#endif



- (void)mcMutable_setObject:(id)object forKey:(id<NSCopying>)key{
    if (!object) {
        return;
    }
    
    if (!key) {
        return;
    }
    
    return [self mcMutable_setObject:object forKey:key];
    
}

- (void)mcMutable_removeObjectForKey:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    
    [self mcMutable_removeObjectForKey:key];
    
}


@end
