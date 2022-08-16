//
//  MCCommonVc.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import "MCCommonVc.h"
#import "MCBaseUtils/MCCustomNavigationBar.h"
#import "MCBaseUtils/MCScreenHeightInfo.h"
#import "UIImage+MCColor.h"
#import "UINavigationController+MCFullScreenPopGesture.h"
@interface MCCommonVc ()

@end

@implementation MCCommonVc

//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//
//    }
//    return self;
//}
//
//
//- (instancetype)initWithCoder:(NSCoder *)coder{
//    if (self = [super initWithCoder:coder]) {
//
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self didInitialize];
}



- (void)didInitialize {
    
    [self.view addSubview:self.customNavBar];
    
    self.customNavBar.barBackgroundImage = [[UIImage imageNamed:@"millcolorGrad"] mc_updateImageWithTintColor:[UIColor whiteColor]];
    
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar mc_setLeftButtonWithTitle:@"返回" titleColor:[UIColor redColor]];
    }
    
}



- (MCCustomNavigationBar *)customNavBar {
    
    if (_customNavBar == nil) {
        _customNavBar = [MCCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

@end
