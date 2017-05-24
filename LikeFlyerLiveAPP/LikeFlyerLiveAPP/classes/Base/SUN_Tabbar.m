//
//  SUN_Tabbar.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/22.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_Tabbar.h"

@interface SUN_Tabbar ()

@property (nonatomic, strong) NSArray  *dataList;

@property (nonatomic, strong) UIImageView *tabbarBackgroundView;

@property (nonatomic, strong) UIButton *lastItem;

@property (nonatomic, strong) UIButton *carmaButton;

@end

@implementation SUN_Tabbar


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self configUI];
        
    }
    
    return self;
}


- (void)configUI{
    [self addSubview:self.tabbarBackgroundView];
    
    for (int i = 0 ; i < self.dataList.count ; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.adjustsImageWhenHighlighted = NO;
        [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        item.tag = i;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (i == 0) {
            item.selected = YES;
            _lastItem = item;
        }
    }
    
    
    [self addSubview:self.carmaButton];
}


#pragma mark ---------------------------------------------- get

- (UIImageView *)tabbarBackgroundView{
    if (!_tabbarBackgroundView) {
        _tabbarBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
//        _tabbarBackgroundView.frame = self.bounds;
    }
    
    return _tabbarBackgroundView;
}

- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    
    return _dataList;
}

- (UIButton *)carmaButton{
    if (!_carmaButton) {
        _carmaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carmaButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_carmaButton sizeToFit];
        _carmaButton.tag = 2;
        _carmaButton.adjustsImageWhenHighlighted = NO;
        [_carmaButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carmaButton;
}



#pragma mark ---------------------------------------------- buttonClick
- (void)itemClick:(UIButton *)button{
   
    
    if (button.tag < 2) {
        _lastItem.selected = NO;
        button.selected = YES;;
        _lastItem = button;
        
        //动画设置
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformMakeScale(1.3, 1.3);
            
        } completion:^(BOOL finished) {
            // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
            [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
                button.transform = CGAffineTransformIdentity;
            } completion:nil];
        }];
    }
 
    if (_didSelectedBlock) {
        _didSelectedBlock(button.tag);
    }
    
}



#pragma mark ---------------------------------------------- layoutFrame
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tabbarBackgroundView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width / 2.0;
    
    for (UIView *view in self.subviews) {
        if (view.tag == 0) {
            view.frame = CGRectMake(0, 0, width, 49);
        }else if (view.tag == 1){
            view.frame = CGRectMake(width, 0, width, 49);
        }else{
            self.carmaButton.center = CGPointMake(K_Width/2.0 , 5);
        }
    }
    
    
}


@end
