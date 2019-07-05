//
//  ViewController.m
//  tios_l_sdk
//
//  Created by Sniper on 2019/7/3.
//  Copyright © 2019年 sl. All rights reserved.
//

#import "ViewController.h"
#import "l_sdkm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    lsdkm* sdk = [lsdkm instance];
    
    [sdk test];
    
}


@end
