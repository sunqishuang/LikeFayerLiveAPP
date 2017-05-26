//
//  SUNAudienceCollectionViewItem.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/26.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUNAudienceCollectionViewItem.h"

@interface SUNAudienceCollectionViewItem ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation SUNAudienceCollectionViewItem

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
        _imgView.layer.cornerRadius = 16;
        _imgView.clipsToBounds = YES;
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:DefaultImage];
}

@end
