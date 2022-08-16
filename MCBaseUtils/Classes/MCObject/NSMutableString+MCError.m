//
//  NSMutableString+MCError.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/11.
//

#import "NSMutableString+MCError.h"

@implementation NSMutableString (MCError)


#ifdef DEBUG

#else


+ (void)load {
    
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        //替换 substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSwizzledFromStr = @"mcMutable_substringFromIndex:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSCFString"), NSSelectorFromString(tmpSubFromStr), NSSelectorFromString(tmpSwizzledFromStr));
        
        
        //替换substringToIndex:
        
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSwizzledSubToStr = @"mcMutable_subStringToIndex";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSCFString"), NSSelectorFromString(tmpSubToStr), NSSelectorFromString(tmpSwizzledSubToStr));
        
        
        
        //替换 subStringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        
        NSString *tmpSwizzledSubRangeStr = @"mcMutable_subStringWithRange:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSCFString"), NSSelectorFromString(tmpSubRangeStr), NSSelectorFromString(tmpSwizzledSubRangeStr));
        
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSwizzledRangeOfStr = @"mcMutable_rangeOfString:options:rang:locale:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSCFString"), NSSelectorFromString(tmpRangeOfStr), NSSelectorFromString(tmpSwizzledRangeOfStr));
        
        
        
        //替换 appendString
        NSString *tmpAppendStr = @"appendString:";
        NSString *tmpSwizzledAppendStr = @"mcMutable_appendString:";
        
        mc_exchangeImplementations(NSClassFromString(@"__NSCFString"), NSSelectorFromString(tmpAppendStr), NSSelectorFromString(tmpSwizzledAppendStr));
        
        
    });
    
}


#endif


- (NSString *)mcMutable_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        return nil;
    }
    
    return [self mcMutable_substringFromIndex:from];
}


- (NSString *)mcMutable_subStringToIndex:(NSUInteger)to{
    if (to > self.length) {
        return nil;
    }
    
    return [self mcMutable_substringFromIndex:to];
}


- (NSString *)mcMutable_subStringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    
    if (range.length > self.length) {
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        return nil;
    }
    
    return [self mcMutable_subStringWithRange:range];
    
}

- (NSRange)mcMutable_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask rang:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    return [self mcMutable_rangeOfString:searchString options:mask rang:rangeOfReceiverToSearch locale:locale];
    
}


- (void)mcMutable_appendString:(NSString *)string{
    if (!string) {
        return;
    }
    
    return [self mcMutable_appendString:string];
    
}

@end
