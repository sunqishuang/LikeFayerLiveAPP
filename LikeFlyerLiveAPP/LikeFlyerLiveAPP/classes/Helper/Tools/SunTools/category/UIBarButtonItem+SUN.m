//
//  UIBarButtonItem+SUN.m
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "UIBarButtonItem+SUN.h"

@implementation UIBarButtonItem (SUN)

+ (instancetype)BDItemWithIcon:(UIImage *)icon heighIcon:(UIImage *)hightIcon target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:icon forState:UIControlStateNormal];
    [button setBackgroundImage:hightIcon forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)BDItemWithIcon:(UIImage *)icon heighIcon:(UIImage *)hightIcon target:(id)target action:(SEL)action AndWidth:(CGFloat)width{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:icon forState:UIControlStateNormal];
    [button setBackgroundImage:hightIcon forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, width, width);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (instancetype)BDItemWithIcon:(UIImage *)icon target:(id)target action:(SEL)action{
    return [UIBarButtonItem BDItemWithIcon:icon heighIcon:icon target:target action:action];
}

+ (instancetype)BDItemWithIcon:(UIImage *)icon target:(id)target action:(SEL)action AndWidth:(CGFloat)width{
    return [UIBarButtonItem BDItemWithIcon:icon heighIcon:icon target:target action:action AndWidth:18];
}


@end
