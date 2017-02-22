//
//  VVideoPageController.m
//  AdPage
//
//  Created by Vols on 2017/2/16.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVideoPageController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface VVideoPageController ()

@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation VVideoPageController {
    MPMoviePlayerController *   _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupVideoPlayer];
}


- (void)setupVideoPlayer {
    _player = [[MPMoviePlayerController alloc] initWithContentURL:_videoURL];
    _player.shouldAutoplay = YES;
    [_player setControlStyle:MPMovieControlStyleNone];
    _player.repeatMode = MPMovieRepeatModeOne;
    [_player.view setFrame:self.view.bounds];
    _player.view.alpha = 0;
    
    [self.view addSubview:_player.view];
    [UIView animateWithDuration:3 animations:^{
        _player.view.alpha = 1;
        [_player prepareToPlay];
    }];
    
    [self setupLoginView];
}

- (void)setupLoginView {

    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0;
    [_player.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:3.0 animations:^{
        enterMainButton.alpha = 1.0;
    }];
}

- (void)enterMainAction:(UIButton *)btn {
    NSLog(@"进入应用");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
