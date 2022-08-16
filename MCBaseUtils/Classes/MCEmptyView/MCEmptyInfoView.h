//
//  MCEmptyInfoView.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/9.
//

#import "MCEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCEmptyInfoView : MCEmptyView
+ (instancetype)mc_emptyInfoView;
+ (instancetype)mc_emptyActionViewWithTarget:(id)Target withAction:(SEL)action;
@end

NS_ASSUME_NONNULL_END
