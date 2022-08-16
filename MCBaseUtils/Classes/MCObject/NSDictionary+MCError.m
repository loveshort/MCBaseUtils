//
//  NSDictionary+MCError.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/11.
//

#import "NSDictionary+MCError.h"
#import "MCMacroDefine.h"
#import "MCRuntime.h"

@implementation NSDictionary (MCError)


#ifdef DEBUG

#else

+ (void)load {
    mc_exchangeImplementationInTwoClasses(NSClassFromString(@"__NSPlaceholderDictionary"), NSSelectorFromString(@"initWithObjects:forKeys:count:"), NSClassFromString(@"NSDictionary"), NSSelectorFromString(@"initWithObjects_st:forKeys:count:"));
}

#endif

- (instancetype)initWithObjects_st:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }else{
            rightCount++;
        }
    }
    
    self = [self initWithObjects_st:objects forKeys:keys count:count];
    
    return self;
}

@end
