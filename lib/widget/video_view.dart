import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart'; // 视频播放器
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const VideoView(this.url,
      {Key? key,
      this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16.0 / 9.0})
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
    initializePlayer();
  }

  initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController?.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        aspectRatio: widget.aspectRatio);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
    chewieController?.dispose();
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
