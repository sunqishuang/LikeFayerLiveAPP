//
//  SUN_LanceController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_LanceController.h"

#import "SUN_LiveController.h"

@interface SUN_LanceController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation SUN_LanceController

- (void)viewDidLoad {
    [super viewDidLoad];


    _startButton.layer.cornerRadius = 15;
    _startButton.layer.borderWidth = 1;
    _startButton.layer.borderColor = [UIColor whiteColor].CGColor;

}



- (IBAction)closeButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



/**
 开始直播
 */
- (IBAction)StartLiveClick:(id)sender {
    
    
    [self.navigationController pushViewController:[SUN_LiveController new] animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





 
 
 
 

@end
