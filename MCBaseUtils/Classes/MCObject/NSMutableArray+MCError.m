//
//  NSMutableArray+MCError.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/11.
//

#import "NSMutableArray+MCError.h"
#import "MCRuntime.h"



@implementation NSMutableArray (MCError)

#if DEBUG

#else

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换objectAtIndex:
        
        NSString *tmpGetStr = @"objectAtIndex:";
        NSString *tmpSwizzledGetStr = @"mcMutable_objectAtIndex";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayM"),NSSelectorFromString(tmpGetStr), NSSelectorFromString(tmpSwizzledGetStr));
        
        
        //替换removeObjectsInRange:
        NSString *tmpRemoveStr = @"removeObjectsInRange:";
        NSString *tmpSwizzledRemoveStr = @"mcMutable_removeObjectsInRange:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayM"), NSSelectorFromString(tmpRemoveStr), NSSelectorFromString(tmpSwizzledRemoveStr));
        
        
        //替换 insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *tmpSwizzledInsertStr = @"mcMutable_InsertObject:atIndex:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayM"), NSSelectorFromString(tmpInsertStr), NSSelectorFromString(tmpSwizzledInsertStr));
        
        
        //替换 removeOjbect:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *tmpSwizzledRemoveRangeStr = @"mcMutable_removeObject:inRange:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayM"), NSSelectorFromString(tmpRemoveRangeStr), NSSelectorFromString(tmpSwizzledRemoveRangeStr));
        
        //替换 objectAtIndexedSubscript
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"mcMutable_objectAtIndexedSubscript:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayM"), NSSelectorFromString(tmpSubscriptStr), NSSelectorFromString(tmpSecondSubscriptStr));
        
    });
    
}

#endif





- (id)mcMutable_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    
    return [self mcMutable_objectAtIndex:index];
}


-(void)mcMutable_removeObjectsInRange:(NSRange)range{
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return ;
    }
    
    return [self mcMutable_removeObjectsInRange:range];
}


- (void)mcMutable_removeObject:(id)object inRange:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    if (!object) {
        return;
    }
    
    return [self mcMutable_removeObject:object inRange:range];
}


- (void)mcMutable_InsertObject:(id)object atIndex:(NSUInteger)index{
    if (index > self.count) {
        return;
    }
    
    if (!object) {
        return;
    }
    
    [self mcMutable_InsertObject:object atIndex:index];
}

- (instancetype)mcMutable_objectAtIndexedSubscript:(NSInteger)index {
    if (index >= self.count) {
        return nil;
    }
    
    return [self mcMutable_objectAtIndexedSubscript:index];
    
}


@end
