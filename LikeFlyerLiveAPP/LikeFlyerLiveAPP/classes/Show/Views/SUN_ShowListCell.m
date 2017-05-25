//
//  SUN_ShowListCell.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/24.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_ShowListCell.h"

@interface SUN_ShowListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *zhiboTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@end


@implementation SUN_ShowListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _zhiboTypeLabel.layer.borderWidth = 1;
    _zhiboTypeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _zhiboTypeLabel.layer.cornerRadius = 9;
    _zhiboTypeLabel.clipsToBounds = YES;
    

}


- (void)setModel:(SUN_ShowListModel *)model{
    _model = model;
    
    
    NSLog(@"head === %@",model.creator.portrait);
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:DefaultImage];
    
    _nameLabel.text = model.creator.nick;
    _numLabel.text = [NSString stringWithFormat:@"%@在看",model.online_users];
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:DefaultImage];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
