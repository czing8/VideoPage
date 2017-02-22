//
//  ViewController.m
//  VideoLaunchPage
//
//  Created by Vols on 2017/2/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "ViewController.h"
#import "VVideoPage.h"
#import "VVideoPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)avPlayerClick:(id)sender {
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"];
    if (filePath == nil) {
        NSLog(@"路径不能为空");
        return;
    }
    
    VVideoPage * videoPage = [VVideoPage videoPageWithVideoURL:[NSURL fileURLWithPath:filePath]];
    [videoPage showInWindowWithAnimationType:VideoTransAnimationTypeNone clickHandler:^{
        NSLog(@"进入应用");
    }];
}


- (IBAction)mpMoviePlayerClick:(id)sender {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"];
    if (filePath == nil) {
        NSLog(@"路径不能为空");
        return;
    }

    VVideoPageController * controller = [[VVideoPageController alloc] init];
    controller.videoURL = [NSURL fileURLWithPath:filePath];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
