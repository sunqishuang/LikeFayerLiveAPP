//
//  SUN_NearbyCollectionItem.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_NearbyCollectionItem.h"

@interface SUN_NearbyCollectionItem ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation SUN_NearbyCollectionItem



- (void)showAnimation{
    
    if (self.model.animation) {
        return;
    }
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{

        self.model.animation = YES;
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);

    }];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SUN_NearListModel *)model{
    _model = model;
    
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.info.creator.portrait] placeholderImage:DefaultImage];
    
    _levelLabel.text = [NSString stringWithFormat:@"lv%@",model.info.creator.level];
    
    _distanceLabel.text = model.info.distance;
}


@end
