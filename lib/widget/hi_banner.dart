import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/video_data_model.dart';

class HiBanner extends StatelessWidget {
  final List<VideoData> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;
  final ValueChanged<VideoData>? valueChanged;
  const HiBanner(this.bannerList,
      {Key? key,
      this.bannerHeight = 160,
      this.padding = EdgeInsetsGeometry.infinity,
      this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.bannerHeight,
      child: _banner(),
      padding: EdgeInsets.only(bottom: 8),
    );
  }

  _banner() {
    var right = 10 + padding.horizontal / 2;
    print("bannerList.length:${bannerList.length}");
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      pagination: new SwiperPagination(alignment: Alignment.bottomRight),
      // control: new SwiperControl(),
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
    );
  }

  _image(VideoData bannerModel) {
    return InkWell(
      onTap: () {
        if (this.valueChanged != null) {
          this.valueChanged!(bannerModel);
        }
      },
      child: Container(
        // padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(bannerModel.pic ?? "", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
