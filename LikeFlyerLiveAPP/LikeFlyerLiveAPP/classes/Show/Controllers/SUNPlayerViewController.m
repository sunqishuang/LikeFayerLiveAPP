//
//  SUNPlayerViewController.m
//  LikeFlyerLiveAPP
//
//  Created by zxy on 2017/5/25.
//  Copyright © 2017年 SunQishuang. All rights reserved.
//

#import "SUNPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "SUNPlayerChlidController.h"

@interface SUNPlayerViewController ()

@property(atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIImageView *blurImageView;

@property (nonatomic, strong) SUNPlayerChlidController *chlidVC;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation SUNPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //配置播放器
    [self configPlayer];
    
    
    //初始化UI
    [self configUI];
    
    
    //初始化子控制器
    [self addChlidVC];
}






- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;

    [super viewWillAppear:animated];

    
    //注册通知
    [self installMovieNotificationObservers];
    
    //准备播放
    [self.player prepareToPlay];
    

    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"bar ==== %@",self.navigationController.navigationBar);
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidDisappear:(BOOL)animated {
    
 
    [super viewDidDisappear:animated];
    
   
    //结束播放
    [self.player shutdown];
    
    //移除通知
    [self removeMovieNotificationObservers];
    


}


#pragma mark ---------------------------------------------- GET
- (SUNPlayerChlidController *)chlidVC{
    if (!_chlidVC) {
        _chlidVC = [[SUNPlayerChlidController alloc] init];
        _chlidVC.liveModel = _liveModel;
    }
    
    return _chlidVC;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        SUNWEAKSELF
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        closeButton.adjustsImageWhenHighlighted = NO;
        [closeButton bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [closeButton sizeToFit];
        closeButton.frame = CGRectMake(K_Width - closeButton.width - 10, K_Height - closeButton.height - 10, closeButton.width, closeButton.height);

        

        _closeButton = closeButton;
    }
    
    return _closeButton;
}

#pragma mark ---------------------------------------------- 初始化配置Player

- (void)configPlayer{
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_liveModel.stream_addr] withOptions:options];
    
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    
    [self.view addSubview:self.player.view];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_liveModel.creator.portrait] placeholderImage:DefaultImage];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
   
    //创建毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
   
    //创建毛玻璃视图
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.frame = imageView.bounds;
    [imageView addSubview:visualView];
    
    self.blurImageView = imageView;
    
    
    [self.view addSubview:self.closeButton];
    
}


- (void)addChlidVC{
    [self addChildViewController:self.chlidVC];
    [self.view addSubview:self.chlidVC.view];
    
    [self.view bringSubviewToFront:self.closeButton];
    
    [self.chlidVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,  //未知网络
    //    MPMovieLoadStatePlayable       = 1 << 0,  //缓冲结束,可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES   缓冲结束,自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started  暂停
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
        
        [self.blurImageView removeFromSuperview];
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,  //直播结束
    //    MPMovieFinishReasonPlaybackError,  //直播错误
    //    MPMovieFinishReasonUserExited      //退出直播
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,  //停止
    //    MPMoviePlaybackStatePlaying,  //开始
    //    MPMoviePlaybackStatePaused,  //暂停
    //    MPMoviePlaybackStateInterrupted, //终端
    //    MPMoviePlaybackStateSeekingForward, //前进
    //    MPMoviePlaybackStateSeekingBackward  //后退
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}


#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    //监测播放状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    //监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    
    //监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
