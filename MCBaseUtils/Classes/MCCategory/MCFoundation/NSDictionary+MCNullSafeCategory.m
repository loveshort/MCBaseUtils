//
//  NSDictionary+MCNullSafeCategory.m
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#import "NSDictionary+MCNullSafeCategory.h"

@implementation NSDictionary (MCNullSafeCategory)

- (NSString *)mc_stringForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
       return [value stringValue];
    }
    
    return nil;
}

@end
