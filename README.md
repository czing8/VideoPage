# 视频页，可作为视频启动页、登录背景页使用。  

	2种方式实现：AVPlayer 和 MPMoviePlayerController。

	MPMoviePlayerController 在iOS9中被正式废弃，而且会有闪屏现象。建议使用 AVPlayer，利用通知实现循环播放功能。
