//
//  SUN_ShowListModel.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_ShowListModel.h"

@implementation SUN_ShowListModel

- (NSString *)ID{
    return [SUNTools ValueIsNotNull:_ID];
}

- (NSString *)share_addr{
    return [SUNTools ValueIsNotNull:_share_addr];
}


- (NSString *)stream_addr{
    return [SUNTools ValueIsNotNull:_stream_addr];
}


- (NSString *)online_users{
    return [SUNTools ValueIsNotNull:_online_users];
}

- (NSString *)distance{
    return [SUNTools ValueIsNotNull:_distance];
}




@end
