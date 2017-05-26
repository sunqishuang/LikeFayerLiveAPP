//
//  SUN_LiveController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/26.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_LiveController.h"

#import "LFLivePreview.h"

@interface SUN_LiveController ()

@end

@implementation SUN_LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFLivePreview *view = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    SUNWEAKSELF
    view.closeBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
 
    [self.view addSubview:view];

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
