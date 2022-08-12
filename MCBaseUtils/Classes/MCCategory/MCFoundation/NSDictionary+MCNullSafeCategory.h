//
//  NSDictionary+MCNullSafeCategory.h
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MCNullSafeCategory)

- (NSString *)mc_stringForKey:(id)key;

@end

NS_ASSUME_NONNULL_END
