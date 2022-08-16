//
//  NSDictionary+MCJSON.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import "NSDictionary+MCJSON.h"

@implementation NSDictionary (MCJSON)


- (NSString * _Nonnull)mc_dictionaryToJSON {
    return  [NSDictionary mc_dictionaryToJSON:self];
}

+ (NSString * _Nonnull)mc_dictionaryToJSON:(NSDictionary * _Nonnull)dictionary{
    
    NSString *json = nil;
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        return @"{}";
    }else if(!error){
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }else {
        return error.localizedDescription;
    }
    
}


- (instancetype _Nullable)mc_safeObjectForKey:(NSString * _Nonnull)key {
    NSArray *keysArray = [self allKeys];
    if ([keysArray containsObject:key]) {
        return [self objectForKey:key];
    }else {
        return nil;
    }
}


@end
