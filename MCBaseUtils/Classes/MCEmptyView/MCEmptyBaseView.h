//
//  MCEmptyBaseView.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/9.
//

#import <UIKit/UIKit.h>
#import "UIView+MCFrame.h"
NS_ASSUME_NONNULL_BEGIN

//事件回调
typedef void (^MCActionTapBlock)(void);

@interface MCEmptyBaseView : UIView

/*image 和 imageStr 只有一个起效果*/
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *btnTitleStr;


@property (nonatomic,strong,readonly) UIView *contentView;
@property (nonatomic, weak, readonly) id actionBtnTarget;
@property (nonatomic,assign,readonly) SEL actionBtnAction;
@property (nonatomic, copy, readonly) MCActionTapBlock btnClickBlock;
@property (nonatomic,strong,readonly) UIView *customView;


/**
 emptyView点击事件
 */
@property (nonatomic, copy) MCActionTapBlock tapEmptyViewBlock;


///初始化配置
- (void)mc_prepare;

///重置Subviews
- (void)mc_setupSubviews;


/**
 构造方法 - 创建emptyView
 
 @param image       占位图片
 @param titleStr    标题
 @param detailStr   详细描述
 @param btnTitleStr 按钮的名称
 @param target      响应的对象
 @param action      按钮点击事件
 @return 返回一个emptyView
 */
+ (instancetype)mc_emptyActionViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withTarget:(id)target withAction:(SEL)action;

/**
 构造方法 - 创建emptyView
 
 @param image          占位图片
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 @return 返回一个emptyView
 */
+ (instancetype)mc_emptyActionViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withBtnClickBlock:(MCActionTapBlock)btnClickBlock;

/**
 构造方法 - 创建emptyView
 
 @param imageStr    占位图片名称
 @param titleStr    标题
 @param detailStr   详细描述
 @param btnTitleStr 按钮的名称
 @param target      响应的对象
 @param action      按钮点击事件
 @return 返回一个emptyView
 */
+ (instancetype)mc_emptyActionViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withTarget:(id)target withAction:(SEL)action;

/**
 构造方法 - 创建emptyView
 
 @param imageStr       占位图片名称
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 @return 返回一个emptyView
 */
+ (instancetype)mc_emptyActionViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withBtnClickBlock:(MCActionTapBlock)btnClickBlock;

/**
 构造方法 - 创建emptyView
 
 @param image         占位图片
 @param titleStr      占位描述
 @param detailStr     详细描述
 @return 返回一个没有点击事件的emptyView
 */
+ (instancetype)mc_emptyViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr;

/**
 构造方法 - 创建emptyView
 
 @param imageStr      占位图片名称
 @param titleStr      占位描述
 @param detailStr     详细描述
 @return 返回一个没有点击事件的emptyView
 */
+ (instancetype)mc_emptyViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr;

/**
 构造方法 - 创建一个自定义的emptyView
 
 @param customView 自定义view
 @return 返回一个自定义内容的emptyView
 */
+ (instancetype)mc_emptyViewWithCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
