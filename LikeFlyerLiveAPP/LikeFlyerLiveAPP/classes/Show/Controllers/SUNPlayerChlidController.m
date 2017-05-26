//
//  SUNPlayerChlidController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/25.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUNPlayerChlidController.h"

#import "SUNAudienceCollectionViewItem.h"

@interface SUNPlayerChlidController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isNetwork;

//主播头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *online_usersLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *audienceCollectionView;





@end

@implementation SUNPlayerChlidController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _dataArray = [NSMutableArray array];
    [self initWithTimer];
    
    [self configTopUI];
}



#pragma mark ---------------------------------------------- 顶部视图

- (void)configTopUI{
    
    _iconImageView.layer.cornerRadius = 16;
    _iconImageView.clipsToBounds = YES;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_liveModel.creator.portrait] placeholderImage:DefaultImage];
    _online_usersLabel.text = _liveModel.online_users;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake(32, 32);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _audienceCollectionView.collectionViewLayout = flowLayout;
    
    _audienceCollectionView.dataSource = self;

    _audienceCollectionView.delegate = self;
    _audienceCollectionView.backgroundColor = [UIColor clearColor];

    _audienceCollectionView.showsHorizontalScrollIndicator = NO;

    [_audienceCollectionView registerClass:[SUNAudienceCollectionViewItem class] forCellWithReuseIdentifier:@"SUNAudienceCollectionViewItem"];
    
    [self getAudienceListWithNetwork];
}




#pragma mark ---------------------------------------------- 底部视图

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5", nil];
    }
    return _imageArray;
}



- (void)initWithTimer{
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        [self showMoreLoveAnimateFromView:self.shareButton addToView:self.view];
    });
    dispatch_resume(_timer);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self showMoreLoveAnimateFromView:self.shareButton addToView:self.view];
}


- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    
    imageView.layer.position = position;
    [addToView addSubview:imageView];
    
    NSInteger index = arc4random()%5;
    NSString *imageName = self.imageArray[index];
    imageView.image = [UIImage imageNamed:imageName];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---------------------------------------------- UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}




- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SUNAudienceCollectionViewItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"SUNAudienceCollectionViewItem" forIndexPath:indexPath];
    
    SUN_CreatorModel *model = _dataArray[indexPath.row];
    
    item.imageName = model.portrait;
    
    return item;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    
    NSLog(@"x === %.f   width === %.f",offSetX,scrollView.contentSize.width);
    if (offSetX + K_Width - 107 > scrollView.contentSize.width - 10) {
        if (!_isNetwork) {
            _page += 1;
             _isNetwork = YES;
            [self getAudienceListWithNetwork];
        }
     
    }
}




#pragma mark ---------------------------------------------- network

/**
 获取观众列表
 */
- (void)getAudienceListWithNetwork{
    SUNWEAKSELF
    [SUNHTTPTool getWithPath:@"api/live/users" params:@{@"start":[NSString stringWithFormat:@"%ld",(long)_page],@"id":_liveModel.ID} success:^(id json) {
        NSString *dm_error  = [NSString stringWithFormat:@"%@",json[@"dm_error"]];
        
        if ([dm_error isEqualToString:@"0"]) {
            NSArray *lives = json[@"users"];
            NSString *total = [SUNTools ValueNullISZero:json[@"total"]];
            _online_usersLabel.text = total;
            if ([SUNTools SetValueIsNotNull:lives]) {
                NSArray *arr  = [SUN_CreatorModel mj_objectArrayWithKeyValuesArray:lives];
                [_dataArray addObjectsFromArray:arr];
            }
        }else{
            NSString *error_msg  =  [NSString stringWithFormat:@"%@",json[@"error_msg"]];
            
            NSLog(@"error_msg ==== %@",error_msg);
        }

        [_audienceCollectionView reloadData];
        
        weakSelf.isNetwork = NO;
    } failure:^(NSError *error) {
        weakSelf.isNetwork = NO;
    }];
}






@end
