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



@interface SUN_TabbarController ()<UITabBarControllerDelegate>


@end

@implementation SUN_TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //加载控制器
    [self configViewControllers];

    
   
    
    //加载Tabbar

    [self setValue:self.sun_tabbar forKey:@"tabBar"];
    

    self.delegate = self;

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
                    
                    SUN_NavigationController *nav = [[SUN_NavigationController alloc]initWithRootViewController:lanceVC];
                    nav.navigationBarHidden = YES;
                    
                    [weakSelf presentViewController:nav animated:YES completion:NULL];
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
 
    
    
    SUN_MainViewController *mainVC = [SUN_MainViewController new];
    mainVC.tabBarItem.tag = 0;
    SUN_MineViewController *mineVC = [SUN_MineViewController new];
    mineVC.tabBarItem.tag = 1;
    
    [self cretaeChildViewController:mainVC title:nil Image:[UIImage imageNamed:@"tab_live"] selectedImage:[UIImage imageNamed:@"tab_live_p"]];
    
    [self cretaeChildViewController:mineVC title:nil Image:[UIImage imageNamed:@"tab_me"] selectedImage:[UIImage imageNamed:@"tab_me_p"]];
}




- (void)cretaeChildViewController:(UIViewController *)childVc title:(NSString *)title Image:(UIImage *)image  selectedImage:(UIImage *)selectedImage{
    
    
    childVc.title = title;
    //    childVc.title
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
 
 
    

    
    
   SUN_NavigationController *BDNavigation = [[SUN_NavigationController alloc]initWithRootViewController:childVc];
    

    
    [self addChildViewController:BDNavigation];
    

    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    [self animationWithIndex:self.selectedIndex];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
   
    
    
}

- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.sun_tabbar.subviews){
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            
            [tabbarbuttonArray addObject:tabBarButton];
            
        }
        
    }
    
    
    UIView *tabbarButton = tabbarbuttonArray[index];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        tabbarButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
    } completion:^(BOOL finished) {
        // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
            tabbarButton.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
    
    
    
}






@end
