//
//  GobalHongHeader.h
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#ifndef GobalHongHeader_h
#define GobalHongHeader_h




#define K_Width  [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height
#define SUNWEAKSELF    __weak typeof(self) weakSelf = self;


//我在映客上的推流地址
#define Live_SUNQIHSUANG  @"rtmp://istream4.a8.com/live/1495769270606351?ikProfile=3&ikWidth=576&ikHeight=1024&ikBr=1200&ikFps=20&ikHost=ws&ikOp=1"
//rtmp://istream4.a8.com/live/1495768506054265?ikProfile=3&ikWidth=576&ikHeight=1024&ikBr=1200&ikFps=20&ikHost=ws&ikOp=1

#define DefaultImage [UIImage imageNamed:@"default_room"]
#define BSAECOLOR  [UIColor colorWithRed:36/255.0 green:215/255.0 blue:200/255.0 alpha:1]

#endif /* GobalHongHeader_h */
