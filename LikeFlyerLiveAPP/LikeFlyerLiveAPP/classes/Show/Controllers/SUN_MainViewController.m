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

@interface SUN_MainViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIViewController *showingVC;
@property (nonatomic, strong) UIScrollView *bgScrollView;

@property (nonatomic, strong) BDSegmentView *segment;

@property (nonatomic, strong) UIButton *leftItem;

@property (nonatomic, strong) UIButton *rightItem;




@end

@implementation SUN_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addChildViewController:[SUN_AttentionController new]];
    [self addChildViewController:[SUN_PopularController new]];
    [self addChildViewController:[SUN_NearbyController new]];
    
    
    [self createBgScrollView];

    
    


}



#pragma mark  ---------------------------------------  创建子视图
/**
 *  创建顶部segment
 */
- (void)createSegment{
    _segment = [BDSegmentView BDsegmentWithFrame:CGRectMake(0, 20, K_Width , 44) style:BDSegmentLineStyle];
    _segment.allItemTitleS = [NSMutableArray arrayWithObjects:@"关注",@"热门",@"附近", nil];
    _segment.titleFont = [UIFont systemFontOfSize:15];
    _segment.BDitemColor = [UIColor whiteColor];
    _segment.BDitemSelectedTextColor = [UIColor whiteColor];
    _segment.BDitemSelectedStylrColor = [UIColor whiteColor];
    _segment.isEqualToTextLength = YES;
    //    这句代码决定了,_segment一定要在bgScroll之后创建
    __weak UIScrollView *weakScroll = _bgScrollView;

    // 点击对应的订单按钮btn进来跳转到对应页面
 

    _segment.BDItemClickBlock = ^(NSString *itemName, NSInteger itemIndex){
            [UIView animateWithDuration:0.25 animations:^{
            weakScroll.contentOffset = CGPointMake(K_Width * itemIndex, 0);

            }];
        };
  
    self.navigationItem.titleView = _segment;

    
}

/**
 *  创建背景scrollView
 */
- (void)createBgScrollView{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, K_Width, K_Height  - 49 - 64)];
    _bgScrollView.bounces = NO;
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.contentSize = CGSizeMake(K_Width * 3, _bgScrollView.frame.size.height);
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    for (int i = 0; i < 3; i ++) {
        
        
        SUN_NearbyController *vc = self.childViewControllers[i];
        
        vc.viewFrame = CGRectMake(K_Width * i, 0 , K_Width, _bgScrollView.frame.size.height);

        [_bgScrollView addSubview:vc.view];
        
    }
    
    [self createSegment];
}

#pragma mark --------------------------------- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/K_Width;
    [_segment BDitemClickByIndex:index];
    

    
    
    
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
