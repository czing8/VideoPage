//
//  VideoLaunchPage.m
//  AdPage
//
//  Created by Vols on 2017/2/16.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVideoPage.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

#import "Masonry.h"

#define kCurWindow  [[UIApplication sharedApplication].windows firstObject]

@interface VVideoPage ()

@property (nonatomic, strong) NSURL     * videoURL;

@property (nonatomic, strong) UIButton  * enterButton;

@end

@implementation VVideoPage {
    AVPlayer        * _avPlayer;
    AVPlayerLayer   * _playerLayer;
}

#pragma mark - Public

+ (instancetype)videoPageWithVideoURL:(NSURL *)videoURL {
    VVideoPage *videoPage = [[VVideoPage alloc] initWithVideoURL:videoURL];
    return videoPage;
}

+ (instancetype)videoPageWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL {
    VVideoPage *videoPage = [[VVideoPage alloc] initWithVideoURL:videoURL];
    videoPage.frame = frame;
    return videoPage;
}

- (void)showInWindowWithAnimationType:(VideoTransAnimationType)animationType clickHandler:(VideoPageNoParmaBlock)clickHandler {
    [self showInView:kCurWindow animationType:animationType clickHandler:clickHandler];
}

- (void)showInView:(UIView *)superView animationType:(VideoTransAnimationType)animationType clickHandler:(VideoPageNoParmaBlock)clickHandler {
    if (superView == nil) {
        NSLog(@"superView can't nil");
        return;
    }

    self.clickHandler = clickHandler;
    superView.hidden = NO;
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    [self layoutIfNeeded];
    self.animationType = animationType;
 
    [self play];
}

#pragma mark - Lifecycle

- (void)dealloc {
    [_avPlayer.currentItem cancelPendingSeeks];
    [_avPlayer.currentItem.asset cancelLoading];
    [_playerLayer removeFromSuperlayer];
    _playerLayer = nil;
    _avPlayer = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithVideoURL:(NSURL *)videoURL {
    if (self = [super init]) {
        self.alpha = 0;
        self.backgroundColor = [UIColor clearColor];
        _videoURL = videoURL;

        [self configureAVPlayer];
        
        [self addSubview:self.enterButton];
    }
    return self;
}

- (void)configureAVPlayer {
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:_videoURL options:nil];
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    _avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)play {
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
        [_avPlayer play];
    }];
}

#pragma mark - Properties

- (UIButton *)enterButton {
    if (_enterButton == nil) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
        _enterButton.layer.borderWidth = 1;
        _enterButton.layer.cornerRadius = 24;
        _enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _enterButton.layer.masksToBounds = YES;
        [_enterButton setTitle:@"进入应用" forState:UIControlStateNormal];
        _enterButton.tintColor = [UIColor whiteColor];
        _enterButton.backgroundColor = [UIColor clearColor];
        [_enterButton addTarget:self
                         action:@selector(enterMainAction:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}


#pragma mark - Actions

- (void)enterMainAction:(UIButton *)btn {
    if (self.clickHandler) {
        self.clickHandler();
    }
    
    [self dismissAnimation];
}

- (void)runLoopTheMovie:(NSNotification *)notification{
    
    AVPlayerItem * playerItem = [notification object];
    //关键代码
    [playerItem seekToTime:kCMTimeZero];
    [_avPlayer play];
    NSLog(@"重播");
}

- (void)dismissAnimation {
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // layer无法使用Autolayout（masonry），所以在layoutSubviews里使用frame
    NSLog(@"layoutSubviews --> %@", NSStringFromCGRect(self.bounds));
    _playerLayer.frame = self.bounds;
}
#pragma mark - Properties


@end
