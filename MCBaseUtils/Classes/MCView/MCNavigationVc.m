//
//  MCNavigationVc.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import "MCNavigationVc.h"

@interface MCNavigationVc ()

@end

@implementation MCNavigationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
