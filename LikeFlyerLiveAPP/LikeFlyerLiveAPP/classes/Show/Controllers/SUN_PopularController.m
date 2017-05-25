//
//  SUN_PopularController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_PopularController.h"

#import "SUN_ShowListCell.h"
#import "ScrollListModel.h"

#import "SUN_WKWebViewController.h"

#import "SUNPlayerViewController.h"

@interface SUN_PopularController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray <ScrollListModel *>*scrollDataList;


@property (nonatomic, strong) SDCycleScrollView *headerScrollView;


@end

@implementation SUN_PopularController

- (void)viewDidLoad {
    [super viewDidLoad];

       self.view.frame = _viewFrame;
    
    [self.view addSubview:self.tableView];
    
    
    
    

        [self getDataWithNetwork];
    [self getScrollListDataWithNetwork];
        

}


- (void)setScrollDataList:(NSMutableArray<ScrollListModel *> *)scrollDataList{
    _scrollDataList = scrollDataList;
    
   
    
    
    _headerScrollView.imageURLStringsGroup = [SUNTools getArrayForSuperModel:scrollDataList WithPropertyName:@"image"];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerScrollView adjustWhenControllerViewWillAppera];
}

- (SDCycleScrollView *)headerScrollView{
    if (!_headerScrollView) {
        _headerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, K_Width, K_Width * 150/375) delegate:self placeholderImage:DefaultImage];
        _headerScrollView.currentPageDotColor = BSAECOLOR;
        _headerScrollView.pageDotColor = [UIColor whiteColor];
        _headerScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerScrollView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_Width, K_Height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerScrollView;
        [_tableView registerNib:[UINib nibWithNibName:@"SUN_ShowListCell" bundle:nil] forCellReuseIdentifier:@"SUN_ShowListCell"];
        
    }
    return _tableView;
}

#pragma mark ---------------------------------------------- 点击图片回调
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ScrollListModel *model = _scrollDataList[index];
    
    SUN_WKWebViewController *vc = [[SUN_WKWebViewController alloc] init];
    vc.UrlStr = model.link;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68 + K_Width;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SUN_ShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SUN_ShowListCell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SUN_ShowListModel *model = _dataArray[indexPath.row];
    
    
    SUNPlayerViewController *vc = [[SUNPlayerViewController alloc] init];
    
    vc.liveModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---------------------------------------------- network

- (void)getDataWithNetwork{
    [SUNHTTPTool getWithPath:@"api/live/simpleall" params:nil success:^(id json) {
        NSString *dm_error  = [NSString stringWithFormat:@"%@",json[@"dm_error"]];
        if ([dm_error isEqualToString:@"0"]) {
            NSArray *lives = json[@"lives"];
            if ([SUNTools SetValueIsNotNull:lives]) {
                _dataArray = [SUN_ShowListModel mj_objectArrayWithKeyValuesArray:lives];
            }
        }else{
            NSString *error_msg  =  [NSString stringWithFormat:@"%@",json[@"error_msg"]];
            
            NSLog(@"error_msg ==== %@",error_msg);
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (void)getScrollListDataWithNetwork{
    SUNWEAKSELF
    [SUNHTTPTool getWithPath:@"api/live/ticker" params:nil success:^(id json) {
        NSString *dm_error  = [NSString stringWithFormat:@"%@",json[@"dm_error"]];
        if ([dm_error isEqualToString:@"0"]) {
            NSArray *ticker = json[@"ticker"];
            if ([SUNTools SetValueIsNotNull:ticker]) {
                weakSelf.scrollDataList = [ScrollListModel mj_objectArrayWithKeyValuesArray:ticker];
            }
        }else{
            NSString *error_msg  =  [NSString stringWithFormat:@"%@",json[@"error_msg"]];
            
            NSLog(@"error_msg ==== %@",error_msg);
        }

        
        
    } failure:^(NSError *error) {
        
    }];
}





@end
