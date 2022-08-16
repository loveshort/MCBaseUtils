//
//  UIView+Empty.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2018/5/10.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>
#import "MCEmptyView.h"

#pragma mark - ------------------ UIView ------------------

@implementation UIView (Empty)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

#pragma mark - Setter/Getter

static char kEmptyViewKey;
- (void)setMc_emptyView:(MCEmptyView *)mc_emptyView{
    if (mc_emptyView != self.mc_emptyView) {
        
        objc_setAssociatedObject(self, &kEmptyViewKey, mc_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[MCEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.mc_emptyView];
        
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) {
            [self getDataAndSet]; // 添加时根据DataSource去决定显隐
        } else {
            self.mc_emptyView.hidden = YES;// 添加时默认隐藏
        }
    }
}
- (MCEmptyView *)mc_emptyView{
    return  objc_getAssociatedObject(self, &kEmptyViewKey);
}

#pragma mark - Private Method (UITableView、UICollectionView有效)
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}
- (void)getDataAndSet{
    //没有设置emptyView的，直接返回
    if (!self.mc_emptyView) {
        return;
    }
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}
- (void)show{
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 mc_showEmptyView
    if (!self.mc_emptyView.autoShowEmptyView) {
        return;
    }
    
    [self mc_showEmptyView];
}
- (void)hide{
    //当不自动显隐时，内部自动调用hide方法时也不要去隐藏，要隐藏的话只有手动去调用 mc_hideEmptyView
    if (!self.mc_emptyView.autoShowEmptyView) {
        return;
    }
    
    [self mc_hideEmptyView];
}

#pragma mark - Public Method
- (void)mc_showEmptyView{
    
    NSAssert(![self isKindOfClass:[MCEmptyView class]], @"LYEmptyView及其子类不能调用mc_showEmptyView方法");

    self.mc_emptyView.hidden = NO;
    
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.mc_emptyView];
}
- (void)mc_hideEmptyView{
    NSAssert(![self isKindOfClass:[MCEmptyView class]], @"LYEmptyView及其子类不能调用mc_hideEmptyView方法");
    self.mc_emptyView.hidden = YES;
}
- (void)mc_startLoading{
    NSAssert(![self isKindOfClass:[MCEmptyView class]], @"LYEmptyView及其子类不能调用mc_startLoading方法");
    self.mc_emptyView.hidden = YES;
}
- (void)mc_endLoading{
    NSAssert(![self isKindOfClass:[MCEmptyView class]], @"LYEmptyView及其子类不能调用mc_endLoading方法");
    self.mc_emptyView.hidden = [self totalDataCount];
}

@end

#pragma mark - ------------------ UITableView ------------------

@implementation UITableView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mc_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(mc_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(mc_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(mc_reloadSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(mc_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(mc_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(mc_reloadRowsAtIndexPaths:withRowAnimation:)];
}
- (void)mc_reloadData{
    [self mc_reloadData];
    [self getDataAndSet];
}
///section
- (void)mc_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)mc_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)mc_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_reloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)mc_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)mc_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)mc_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self mc_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (Empty)

+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mc_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(mc_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(mc_deleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(mc_reloadSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(mc_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(mc_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(mc_reloadItemsAtIndexPaths:)];
    
}
- (void)mc_reloadData{
    [self mc_reloadData];
    [self getDataAndSet];
}
///section
- (void)mc_insertSections:(NSIndexSet *)sections{
    [self mc_insertSections:sections];
    [self getDataAndSet];
}
- (void)mc_deleteSections:(NSIndexSet *)sections{
    [self mc_deleteSections:sections];
    [self getDataAndSet];
}
- (void)mc_reloadSections:(NSIndexSet *)sections{
    [self mc_reloadSections:sections];
    [self getDataAndSet];
}

///item
- (void)mc_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self mc_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)mc_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self mc_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)mc_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self mc_reloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
@end

