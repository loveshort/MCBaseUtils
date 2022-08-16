//
//  UINavigationController+MCFullScreenPopGesture.h
//  MCBaseUtils
//
//  Created by mingci on 2021/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (MCFullScreenPopGesture)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *mc_fullscreenPopGestureRecognizer;

@property (nonatomic, assign) BOOL mc_viewControllerBasedNavigationBarAppearanceEnabled;

@end



@interface UIViewController (MCFullScreenPopGesture)

@property (nonatomic, assign) BOOL mc_interactivePopDisabled;

 
@property (nonatomic, assign) BOOL mc_prefersNavigationBarHidden;

 
@property (nonatomic, assign) CGFloat mc_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end


NS_ASSUME_NONNULL_END
