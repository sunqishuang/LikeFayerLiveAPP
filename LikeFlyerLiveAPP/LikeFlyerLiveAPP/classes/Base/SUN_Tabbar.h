//
//  SUN_Tabbar.h
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/22.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <UIKit/UIKit.h>


/** index 0:主页   1:我的  2:直播 */
typedef void(^SUNTabbarDisSelectedBlock)(NSInteger index);


@interface SUN_Tabbar : UIView


@property (nonatomic, copy) SUNTabbarDisSelectedBlock didSelectedBlock;

@end
