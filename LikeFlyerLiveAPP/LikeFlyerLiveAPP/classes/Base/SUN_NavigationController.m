//
//  SUN_NavigationController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/22.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_NavigationController.h"

@interface SUN_NavigationController ()

@end

@implementation SUN_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];



}

+ (void)initialize{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    UIColor * radomcolor = [UIColor colorWithRed:36/255.0 green:215/255.0 blue:200/255.0 alpha:1];
    
    navBar.barTintColor = radomcolor;
    
    navBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
