import 'package:flutter/material.dart';
import '../model/video_data_model.dart';
import '../widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoData? videoModel;

  const VideoDetailPage({Key? key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text("视频详情页，vid：${widget.videoModel?.aid}"),
            Text("视频详情页，title：${widget.videoModel?.title}"),
            _videoView()
          ],
        ));
  }

  _videoView() {
    //
    return VideoView("https://www.bilibili.com/video/BV1r44y1M7QV");
  }
}
