//
//  MCEmptyInfoView.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/9.
//

#import "MCEmptyInfoView.h"
#import "UIImage+MCFileName.h"
#import "UIColor+MCHex.h"

@implementation MCEmptyInfoView

+ (instancetype)mc_emptyInfoView {

    return [MCEmptyInfoView mc_emptyViewWithImage:[UIImage mc_imageWithFileName:@"nodata" withBundle:[NSBundle bundleForClass:[self class]]] withTitleStr:@"暂无数据" withDetailStr:@"请稍后再试!"];
}

+ (instancetype)mc_emptyActionViewWithTarget:(id)Target withAction:(SEL)action {
    
    return [MCEmptyInfoView mc_emptyActionViewWithImage:[UIImage mc_imageWithFileName:@"noNetwork" withBundle:[NSBundle bundleForClass:[self class]]] withTitleStr:@"无网络连接" withDetailStr:@"请检查你的网络连接是否正确!" withBtnTitleStr:@"重新加载" withTarget:Target withAction:action];
}


- (void)mc_prepare {
    [super mc_prepare];
    
    self.autoShowEmptyView = NO;
    self.titleLabTextColor = mc_hex(@"#FA1D22");
    self.titleLabFont = [UIFont systemFontOfSize:18];
    self.detailLabTextColor = mc_hex(@"#4A7A1D");
}

@end
