//
//  ScrollListModel.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "ScrollListModel.h"

@implementation ScrollListModel

- (NSString *)image{
    return [SUNTools ValueIsNotNull:_image];
}


- (NSString *)link{
    return [SUNTools ValueIsNotNull:_link];
}


@end
