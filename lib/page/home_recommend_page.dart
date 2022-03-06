import 'package:blibli/EventBus/event_notification.dart';
import 'package:blibli/core/hi_state.dart';
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

class _HomeRecommendPageState extends HiState<HomeRecommendPage>
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
        removeTop: true, context: context, child: _contentViewData());
  }

  _banner() {
    print("widget.bannerList:${widget.bannerList}");
    return HiBanner(
      widget.bannerList,
      valueChanged: (videoModel) {
        print("点击：${videoModel}");
      },
    );
  }

  _contentViewData() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _getShowData(),
      ),
    );
  }

  List<Widget> _getShowData() {
    List<Widget> li = [];
    if (!widget.bannerList.isEmpty) {
      li.add(StaggeredGridTile.count(
          crossAxisCellCount: 2, mainAxisCellCount: 1, child: _banner()));
      widget.bannerList.forEach((element) {
        li.add(StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 0.6,
            child: VideoCard(
              videoData: element,
            )));
      });
    }

    return li;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
