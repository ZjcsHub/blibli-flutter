import 'package:flutter/material.dart';
import '../model/video_data_model.dart';

class VideoCard extends StatelessWidget {
  final VideoData? videoData;
  final ValueChanged<VideoData?>? valueChanged;
  const VideoCard({Key? key, this.videoData, this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.valueChanged != null) {
          this.valueChanged!(this.videoData);
        }
      },
      child: Container(
        height: 120,
        child: Image.network(
          this.videoData?.pic ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
