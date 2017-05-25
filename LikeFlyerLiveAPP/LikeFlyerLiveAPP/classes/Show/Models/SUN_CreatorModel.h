//
//  SUN_CreatorModel.h
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUN_CreatorModel : NSObject

/**  */
@property (nonatomic,copy) NSString *ID;

/** 等级 */
@property (nonatomic,copy) NSString *level ;

/** 0:女性  1:男性 */
@property (nonatomic,copy) NSString *gender ;

/** 昵称 */
@property (nonatomic,copy) NSString *nick ;

/** 头像地址  */
@property (nonatomic,copy) NSString *portrait ;


@end
