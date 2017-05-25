//
//  SUN_CreatorModel.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_CreatorModel.h"

@implementation SUN_CreatorModel

- (NSString *)ID{
    return [SUNTools ValueIsNotNull:_ID];
}

- (NSString *)level{
    return [SUNTools ValueIsNotNull:_level];
}

- (NSString *)gender{
    return [SUNTools ValueIsNotNull:_gender];
}

- (NSString *)nick{
    return [SUNTools ValueIsNotNull:_nick];
}

- (NSString *)portrait{
    return [SUNTools ValueIsNotNull:_portrait];
}

@end
