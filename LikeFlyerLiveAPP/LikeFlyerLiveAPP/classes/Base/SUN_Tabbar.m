//
//  SUN_Tabbar.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/22.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_Tabbar.h"

@interface SUN_Tabbar ()<UITabBarDelegate>

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
//        self.delegate = self;
        
    }
    
    return self;
}


- (void)configUI{
//    [self addSubview:self.tabbarBackgroundView];
    
//    for (int i = 0 ; i < self.dataList.count ; i++) {
//        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
//        item.adjustsImageWhenHighlighted = NO;
//        [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
//        [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
//        item.tag = i;
//        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:item];
//        
//        if (i == 0) {
//            item.selected = YES;
//            _lastItem = item;
//        }
//    }
    
    [self addSubview:self.carmaButton];
    
}


#pragma mark ---------------------------------------------- get


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

 
    if (_didSelectedBlock) {
        _didSelectedBlock(button.tag);
    }
    
    
    
}



#pragma mark ---------------------------------------------- layoutFrame
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.carmaButton.center = CGPointMake(K_Width/2.0 , 5);

    
    
}

// 在自定义UITabBar中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [self.carmaButton convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(self.carmaButton.bounds, newPoint)) {
            view = self.carmaButton;
        }
    }
    return view;
}




@end
