//
//  NSArray+MCError.m
//  MCOCModule
//
//  Created by mingci on 2021/10/14.
//

#import "NSArray+MCError.h"
#import "MCRuntime.h"
/*
  在iOS中NSNumber、NSArray、NSDictionary等这些类都是类簇，一个NSArray的实现可能由多个类组成。
  所以如果想对NSArray进行Swizzing，必须获取到其“真身”进行Swizzing，直接对NSArray进行操作是无效的
    
  通过runtime函数取出本类
  NSArray                   __NSArrayI
  NSMutableArray            __NSArrayM
  NSDictionary              __NSDictionaryI
  NSMutableDictionary       __NSDictionaryM
 
 */

@implementation NSArray (MCError)

#ifdef DEBUG

#else

+ (void)load {
   
    //只执行一次这个方法
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex
        
        NSString *tmpStr = @"objectAtIndex:";
        NSString *tmpFirstStr = @"mc_zeroObjectAtIndex:";
        NSString *tmpThreeStr = @"mc_objectAtIndex:";
        NSString *tmpSecondStr = @"mc_singleObjectAtIndex:";
        
        
        //替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpScondSubscriptStr = @"mc_objectAtIndexedSubscript:";
            
        mc_exchangeImplementations(NSClassFromString(@"__NSArray0"), NSSelectorFromString(tmpStr), NSSelectorFromString(tmpFirstStr));
        
        mc_exchangeImplementations(NSClassFromString(@"__NSSingleObjectArrayI"), NSSelectorFromString(tmpStr), NSSelectorFromString(tmpSecondStr));
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayI"), NSSelectorFromString(tmpStr), NSSelectorFromString(tmpThreeStr));
        
        mc_exchangeImplementations(NSClassFromString(@"__NSArrayI"), NSSelectorFromString(tmpSubscriptStr), NSSelectorFromString(tmpScondSubscriptStr));
        
    });
   
}

#endif




#pragma mark - 交换方法

- (id)mc_objectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self mc_objectAtIndex:index];
}

- (id)mc_singleObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self mc_singleObjectAtIndex:index];
}

- (id)mc_zeroObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self mc_zeroObjectAtIndex:index];
}

- (id)mc_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self mc_objectAtIndexedSubscript:index];
}


@end
