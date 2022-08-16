//
//  UITextField+MCInputLimit.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MCInputLimit)

@property (nonatomic, assign) NSInteger mc_maxLength;

@end

NS_ASSUME_NONNULL_END
