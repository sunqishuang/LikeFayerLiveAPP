//
//  SUN_ShowListModel.h
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SUN_CreatorModel.h"

@interface SUN_ShowListModel : NSObject

/**  */
@property (nonatomic,copy) NSString *ID;

/** 分享地址 */
@property (nonatomic,copy) NSString *share_addr ;

/** 拉流地址 */
@property (nonatomic,copy) NSString *stream_addr ;

/** 在看人数 */
@property (nonatomic,copy) NSString *online_users;

/** <#note#> */
@property (nonatomic,copy) NSString *distance;


@property (nonatomic,strong) SUN_CreatorModel *creator;

@end
