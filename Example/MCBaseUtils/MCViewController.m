//
//  MCViewController.m
//  MCBaseUtils
//
//  Created by mxx on 08/11/2022.
//  Copyright (c) 2022 mxx. All rights reserved.
//

#import "MCViewController.h"

#import <MCBaseUtils/MCBaseUtils.h>

@interface MCViewController ()

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSDictionary * dict = @{@"key":@"value"};
    
    DLog(@"%@",[dict mc_stringForKey:@"key"]);
    
    
    
    
    
    
}

@end
