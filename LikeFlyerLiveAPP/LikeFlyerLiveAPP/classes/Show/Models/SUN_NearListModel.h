//
//  SUN_NearListModel.h
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SUN_ShowListModel.h"

@interface SUN_NearListModel : NSObject

/** <#note#> */
@property (nonatomic,copy) NSString *flow_type;


@property (nonatomic,strong) SUN_ShowListModel *info;

@end
