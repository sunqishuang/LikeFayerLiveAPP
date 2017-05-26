//
//  SUN_NearbyController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_NearbyController.h"

#import "SUN_NearbyCollectionItem.h"

#import "SUNPlayerViewController.h"

@interface SUN_NearbyController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SUN_NearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = _viewFrame;

    [self.view addSubview:self.collectionView];

    [self getDataWithNetwork];


}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (K_Width - 20)/3.0;
        layout.itemSize = CGSizeMake(width, width  + 24);
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, K_Width, K_Height - 64 - 49) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SUN_NearbyCollectionItem" bundle:nil] forCellWithReuseIdentifier:@"SUN_NearbyCollectionItem"];
     
        SUNWEAKSELF
        _collectionView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            
            [weakSelf getDataWithNetwork];
        }];

    }
    
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SUN_NearbyCollectionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"SUN_NearbyCollectionItem" forIndexPath:indexPath];
    
    
    item.model = _dataArray[indexPath.row];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SUN_NearListModel *model = _dataArray[indexPath.row];
    SUNPlayerViewController *vc = [SUNPlayerViewController new];
    vc.liveModel = model.info;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}






//item将要出现的时候调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SUN_NearbyCollectionItem *item = (SUN_NearbyCollectionItem *)cell;
    
 
    [item showAnimation];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataWithNetwork{
    
    //这里的uid写死,不想写映客的注册登录系统了.
    [SUNHTTPTool getWithPath:@"api/live/near_flow_old" params:@{@"uid":@"286033960"} success:^(id json) {
        NSString *dm_error  = [NSString stringWithFormat:@"%@",json[@"dm_error"]];
        if ([dm_error isEqualToString:@"0"]) {
            NSArray *flow = json[@"flow"];
            if ([SUNTools SetValueIsNotNull:flow]) {
                _dataArray = [SUN_NearListModel mj_objectArrayWithKeyValuesArray:flow];
            }
        }else{
            NSString *error_msg  =  [NSString stringWithFormat:@"%@",json[@"error_msg"]];
            
            NSLog(@"error_msg ==== %@",error_msg);
        }
         [SUNTools tableViewEndrRefresh:_collectionView];
        [_collectionView reloadData];

    } failure:^(NSError *error) {
        
    }];
    
}





@end
