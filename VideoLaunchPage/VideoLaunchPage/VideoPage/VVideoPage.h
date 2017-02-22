//
//  VideoLaunchPage.h
//  AdPage
//
//  Created by Vols on 2017/2/16.
//  Copyright © 2017年 vols. All rights reserved.
//

/****************************
 *  MPMoviePlayerController 会有闪屏,而且在iOS9中被正式废弃，所以使用 AVPlayer 利用通知实现循环播放
 *
 *
 ****************************/

#import <UIKit/UIKit.h>

typedef void (^VideoPageNoParmaBlock)();

typedef NS_ENUM(NSUInteger, VideoTransAnimationType) {
    VideoTransAnimationTypeNone,
};

@interface VVideoPage : UIView

@property (nonatomic ,assign) VideoTransAnimationType   animationType;

@property (nonatomic, copy  ) VideoPageNoParmaBlock     clickHandler;
@property (nonatomic, copy  ) VideoPageNoParmaBlock     dismissHandler;

+ (instancetype)videoPageWithVideoURL:(NSURL *)videoURL;

+ (instancetype)videoPageWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL;

- (void)showInWindowWithAnimationType:(VideoTransAnimationType)animationType clickHandler:(VideoPageNoParmaBlock)clickHandler;
- (void)showInView:(UIView *)superView animationType:(VideoTransAnimationType)animationType clickHandler:(VideoPageNoParmaBlock)clickHandler;

- (void)dismissAnimation;

@end
