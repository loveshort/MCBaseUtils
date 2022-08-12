//
//  UIWindow+MCTopViewController.m
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/12.
//  Copyright © 2022 mxx. All rights reserved.
//

#import "UIWindow+MCTopViewController.h"

@implementation UIWindow (MCTopViewController)


/// 最上层UIViewController
- (UIViewController *)mc_topMostController {
    UIViewController *topController = [self rootViewController];
    
    while ([topController presentingViewController]) {
        topController = [topController presentingViewController];
    }
    
    return  topController;
    
}


///最顶层UIViewController
- (UIViewController *)mc_currentViewController {
    UIViewController *currentViewController = [self mc_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)currentViewController topViewController]) {
        currentViewController = [(UINavigationController *)currentViewController topViewController];
        return currentViewController;
    }
    
}


@end
