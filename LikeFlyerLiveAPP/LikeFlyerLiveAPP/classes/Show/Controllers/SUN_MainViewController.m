//
//  SUN_MainViewController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_MainViewController.h"

#import "SUN_AttentionController.h"
#import "SUN_PopularController.h"
#import "SUN_NearbyController.h"

@interface SUN_MainViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>{
    NSArray *_segmengTitleArray;
}
@property (nonatomic, strong) VTMagicController *magicController;

@property (nonatomic, strong) UIButton *leftItem;

@property (nonatomic, strong) UIButton *rightItem;




@end

@implementation SUN_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUPNavigitionBar];
    
    [self setUpMagicController];


}


- (void)setUPNavigitionBar{
    
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, K_Width/5.0, 44);
    [leftItem setImage:[UIImage imageNamed:@"global_search"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];

    _leftItem = leftItem;
    
    
    UIButton *rightItrm = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItrm.frame = CGRectMake(0, 0, K_Width/5.0, 44);
    [rightItrm setImage:[UIImage imageNamed:@"title_button_more"] forState:UIControlStateNormal];
    [rightItrm addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];

    _rightItem = rightItrm;
}


- (void)setUpMagicController{
    _segmengTitleArray = @[@"关注",@"热门",@"附近"];
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    
    [self.magicController didMoveToParentViewController:self];
    [self.magicController.magicView reloadData];

}


#pragma mark ---------------------------------------------- buttonClick

- (void)leftBarButtonItemClick{
    
}

- (void)rightBarButtonItemClick{
    
}





- (VTMagicController *)magicController{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.frame = CGRectMake(0, 0, K_Width, K_Height);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.scrollEnabled = YES;
        
        _magicController.magicView.sliderColor = [UIColor whiteColor];
        _magicController.magicView.sliderHeight = 1.f;
        _magicController.magicView.sliderWidth = 80;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 44.f;
        
        _magicController.magicView.leftNavigatoinItem = _leftItem;
        _magicController.magicView.rightNavigatoinItem = _rightItem;

        self.navigationItem.titleView = _magicController.magicView.navigationView;
        
    }
    return _magicController;
}



#pragma mark ------------------------------ VTMagicViewDelegate,VTMagicViewDataSource


- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return _segmengTitleArray;
}
- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return menuItem;
}
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex{
    
    switch (pageIndex) {
        case 0:
        {
            static NSString *identify = @"SUN_AttentionController";
            
            SUN_AttentionController *VC = [magicView dequeueReusablePageWithIdentifier:identify];
            if (!VC) {
                VC = [[SUN_AttentionController alloc] init];
            }
            
            return VC;
        
        }
            break;
        case 1:
        {
            static NSString *identify = @"SUN_PopularController";
            
            SUN_PopularController *VC = [magicView dequeueReusablePageWithIdentifier:identify];
            if (!VC) {
                VC = [[SUN_PopularController alloc] init];
            }
            
            return VC;
        }
            break;
        case 2:
        {
            static NSString *identify = @"SUN_NearbyController";
            
            SUN_NearbyController *VC = [magicView dequeueReusablePageWithIdentifier:identify];
            if (!VC) {
                VC = [[SUN_NearbyController alloc] init];
            }
            
            return VC;
        }
            break;
            
        default:  return nil;
            break;
    }
    
    return nil;
    
}


- (void)magicView:(VTMagicView *)magicView viewDidDisappeare:(UIViewController *)viewController
           atPage:(NSUInteger)pageIndex{
    
    
    
}
- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex{
    
    
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
