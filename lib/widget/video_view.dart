import 'package:blibli/util/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart'; // 视频播放器
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';
import 'cutom_video_controller.dart' as CutomController;

class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUi;
  final Widget? barrageUi;

  final VoidCallback? playCallBack;
  final VoidCallback? pauseCallBack;

  const VideoView(this.url,
      {Key? key,
      this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16.0 / 9.0,
      this.overlayUi,
      this.barrageUi,
      this.playCallBack,
      this.pauseCallBack})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    print("widget.cover:${widget.cover}");
    initializePlayer();
  }

  // 封面
  get _placeHolder {
    var contSize = MediaQuery.of(context).size;
    double screenWidth = contSize.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return FractionallySizedBox(
      widthFactor: 1,
      child: cachedImage(widget.cover ?? "",
          width: screenWidth, height: playerHeight),
    );
  }

  // 进度条颜色配置
  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: Colors.grey[500]!);

  initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController?.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        aspectRatio: widget.aspectRatio,
        allowMuting: true,
        placeholder: _placeHolder,
        allowPlaybackSpeedChanging: false,
        materialProgressColors: _progressColors,
        customControls: CutomController.MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlayUi,
          barrageUI: widget.barrageUi,
          playClickAction: widget.playCallBack,
          pauseClickAction: widget.pauseCallBack,
        ));
    chewieController?.addListener(_videoListener);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    chewieController?.removeListener(_videoListener);
    videoPlayerController?.dispose();
    chewieController?.dispose();
  }

  _videoListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      print("size.width:${size.width},size.height:${size.height}");
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    var contSize = MediaQuery.of(context).size;
    double screenWidth = contSize.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: chewieController != null
          ? Chewie(
              controller: chewieController!,
            )
          : Container(),
    );
  }
}
