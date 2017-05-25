//
//  UIImage+SUN.h
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SUN)

/** 初始化一个纯色image */
+ (instancetype)initWithColor:(UIColor *)color;


- (UIImage *)imageWithCornerRadius:(CGFloat)radius;


@end
