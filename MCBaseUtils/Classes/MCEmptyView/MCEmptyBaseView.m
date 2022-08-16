//
//  MCEmptyBaseView.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/9.
//

#import "MCEmptyBaseView.h"

@implementation MCEmptyBaseView

#pragma mark - ------------------ Life Cycle ------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self mc_prepare];
    }
    return self;
}

 

- (void)mc_prepare{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *view = self.superview;
    //不是UIView，不做操作
    if (view && [view isKindOfClass:[UIView class]]){
        self.mc_width = view.mc_width;
        self.mc_height = view.mc_height;
    }
    
    [self mc_setupSubviews];
}

- (void)mc_setupSubviews{
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //不是UIView，不做操作
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]]) return;
    
    if (newSuperview) {
        self.mc_width = newSuperview.mc_width;
        self.mc_height = newSuperview.mc_height;
    }
}

#pragma mark - ------------------ 实例化 ------------------
+ (instancetype)mc_emptyActionViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withTarget:(id)target withAction:(SEL)action{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:target action:action btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)mc_emptyActionViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withBtnClickBlock:(MCActionTapBlock)btnClickBlock{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:nil action:nil btnClickBlock:btnClickBlock];
    
    return emptyView;
}

+ (instancetype)mc_emptyActionViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withTarget:(id)target withAction:(SEL)action{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:target action:action btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)mc_emptyActionViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr withBtnTitleStr:(NSString *)btnTitleStr withBtnClickBlock:(MCActionTapBlock)btnClickBlock{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:nil action:nil btnClickBlock:btnClickBlock];
    
    return emptyView;
}


+ (instancetype)mc_emptyViewWithImage:(UIImage *)image withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image imageStr:nil titleStr:titleStr detailStr:detailStr btnTitleStr:nil target:nil action:nil btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)mc_emptyViewWithImageStr:(NSString *)imageStr withTitleStr:(NSString *)titleStr withDetailStr:(NSString *)detailStr{
    MCEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:nil imageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:nil target:nil action:nil btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)mc_emptyViewWithCustomView:(UIView *)customView {
    
    MCEmptyBaseView *emptyView = [[self alloc] init];
    
    [emptyView creatEmptyViewWithCustomView:customView];
    
    return emptyView;
}

- (void)creatEmptyViewWithImage:(UIImage *)image imageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action btnClickBlock:(MCActionTapBlock)btnClickBlock{
    
    _image = image;
    _imageStr = imageStr;
    _titleStr = titleStr;
    _detailStr = detailStr;
    _btnTitleStr = btnTitleStr;
    _actionBtnTarget = target;
    _actionBtnAction = action;
    _btnClickBlock = btnClickBlock;
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}

- (void)creatEmptyViewWithCustomView:(UIView *)customView{
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    if (!_customView) {
        [_contentView addSubview:customView];
    }
    _customView = customView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - ------------------ Event Method ------------------
- (void)tapEmptyView:(UITapGestureRecognizer *)tap{
    if (_tapEmptyViewBlock) {
        _tapEmptyViewBlock();
    }
}

#pragma mark - ------------------ Setter ------------------

- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsLayout];
}
- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self setNeedsLayout];
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self setNeedsLayout];
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    [self setNeedsLayout];
}
- (void)setBtnTitleStr:(NSString *)btnTitleStr{
    _btnTitleStr = btnTitleStr;
    [self setNeedsLayout];
}


@end
