//
//  UIBarButtonItem+SUN.h
//  category
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SUN)


/**
 *  创建一个带有高亮和普通图片的item
 */
+ (instancetype)BDItemWithIcon:(UIImage *)icon heighIcon:(UIImage *)hightIcon target:(id)target action:(SEL)action;

/**
 *  创建普通状态下的ITem
 */

+ (instancetype)BDItemWithIcon:(UIImage *)icon target:(id)target action:(SEL)action;


+ (instancetype)BDItemWithIcon:(UIImage *)icon target:(id)target action:(SEL)action AndWidth:(CGFloat)width;

@end
