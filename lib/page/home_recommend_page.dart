import 'package:blibli/EventBus/event_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../model/video_data_model.dart';
import '../widget/hi_banner.dart';
import '../widget/video_card.dart';

class HomeRecommendPage extends StatefulWidget {
  List<VideoData> bannerList = [];

  @override
  _HomeRecommendPageState createState() => _HomeRecommendPageState();
}

class _HomeRecommendPageState extends State<HomeRecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    eventBus.on<HomePageChangeEvent>().listen((event) {
      print("接收到通知");
      var dataLists = event.dataList;
      if (dataLists is List<VideoData>) {
        setState(() {
          widget.bannerList = dataLists;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("绘制 home_recommend_page");
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [
            if (!widget.bannerList.isEmpty) _banner(),
          ],
        ));
  }

  _banner() {
    print("widget.bannerList:${widget.bannerList}");
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: HiBanner(
        widget.bannerList,
        valueChanged: (videoModel) {
          print("点击：${videoModel}");
        },
      ),
    );
  }

  _contentViewData() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: widget.bannerList.length,
      itemBuilder: (BuildContext context, int index) =>
          //Container(color: Colors.blue,height:index.isEven?200:250),
          VideoCard(
        videoData: widget.bannerList[index],
      ),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
