//
//  NSDictionary+MCJSON.h
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MCJSON)

- (NSString * _Nonnull)mc_dictionaryToJSON;

+ (NSString * _Nonnull)mc_dictionaryToJSON:(NSDictionary * _Nonnull)dictionary;

- (instancetype _Nullable)mc_safeObjectForKey:(NSString * _Nonnull)key;

@end

NS_ASSUME_NONNULL_END
