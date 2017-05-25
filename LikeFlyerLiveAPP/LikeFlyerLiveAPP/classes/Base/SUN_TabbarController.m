//
//  SUN_TabbarController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/22.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_TabbarController.h"

#import "SUN_MainViewController.h"
#import "SUN_MineViewController.h"
#import "SUN_NavigationController.h"
#import "SUN_LanceController.h"

@interface SUN_TabbarController ()


@end

@implementation SUN_TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //加载控制器
    [self configViewControllers];

    
   
    
    //加载Tabbar
    [self.tabBar addSubview:self.sun_tabbar];
    
    //去掉自身tabbar的上部横线

    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];


}





#pragma mark ---------------------------------------------- GET


- (SUN_Tabbar *)sun_tabbar{
    if (!_sun_tabbar) {
        SUNWEAKSELF
        _sun_tabbar = [[SUN_Tabbar alloc] initWithFrame:CGRectMake(0, 0, K_Width, 49)];
        _sun_tabbar.didSelectedBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    //
                    weakSelf.selectedIndex = 0;
                }
                    break;
                case 1:
                {
                    weakSelf.selectedIndex = 1;
                }
                    break;
                case 2:
                {
                    SUN_LanceController *lanceVC = [[SUN_LanceController alloc] init];
                    
                    [weakSelf presentViewController:lanceVC animated:YES completion:NULL];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _sun_tabbar;
}


#pragma mark ---------------------------------------------- config

- (void)configViewControllers{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"SUN_MainViewController",@"SUN_MineViewController", nil];
    
    for (int i = 0 ; i < array.count; i ++) {
        NSString *VCName = array[i];
        
        UIViewController *vc = [[NSClassFromString(VCName) alloc] init];
        
        SUN_NavigationController *sun_nav = [[SUN_NavigationController alloc] initWithRootViewController:vc];
        
       
        [array replaceObjectAtIndex:i withObject:sun_nav];
    }
    
    self.viewControllers = array;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
