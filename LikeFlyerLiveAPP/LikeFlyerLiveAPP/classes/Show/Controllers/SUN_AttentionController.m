//
//  SUN_AttentionController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/23.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUN_AttentionController.h"

#import "SUN_ShowListCell.h"
#import "SUNPlayerViewController.h"


@interface SUN_AttentionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation SUN_AttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = _viewFrame;
    
    [self.view addSubview:self.tableView];
    
    
    [self getDataWithNetwork];
}



- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_Width, K_Height - 64 - 49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;

        [_tableView registerNib:[UINib nibWithNibName:@"SUN_ShowListCell" bundle:nil] forCellReuseIdentifier:@"SUN_ShowListCell"];
        SUNWEAKSELF
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{

            [weakSelf getDataWithNetwork];
        }];


        
    }
    return _tableView;
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



#pragma mark ---------------------------------------------- network

- (void)getDataWithNetwork{
 
    SUN_ShowListModel *model = [SUN_ShowListModel new];
    model.creator = [SUN_CreatorModel new];
    model.creator.nick = @"孙启双";
    model.creator.portrait = @"http://img2.inke.cn/MTQ5NTc3OTIyMjM4OCMyNjQjanBn.jpg";
    model.stream_addr = Live_SUNQIHSUANG;
    model.online_users = @"100";
    
    _dataArray = [NSMutableArray arrayWithObject:model];
    [_tableView reloadData];

    [_tableView.mj_header endRefreshing];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 
 
 

@end
