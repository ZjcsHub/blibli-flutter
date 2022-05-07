import 'package:blibli/EventBus/event_notification.dart';
import 'package:blibli/core/hi_state.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/util/view_util.dart';
import 'package:blibli/widget/hi_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nested/flutter_nested.dart';
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
    return _forthBuildSecondView();
  }

  // 第一种建造模式
  _firstBuildView() {
    return HiRefresh(
      SingleChildScrollView(
        padding: EdgeInsets.only(top: 5, left: 8, right: 8),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: _getShowData(),
        ),
      ),
      valueChanged: (future) {
        print("执行操作");
      },
    );
  }

  // 第二种建造模式，但是下拉时header不会随着下拉
  _secondBuildView() {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: CustomScrollView(
        slivers: [
          if (!widget.bannerList.isEmpty)
            SliverPersistentHeader(
              delegate: _MySliverPersistentHeaderDelegate(widget.bannerList),
            ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return VideoCard(
                videoData: widget.bannerList[index],
              );
            }, childCount: widget.bannerList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0, //主轴中间间距
              crossAxisSpacing: 4.0, //副轴中间间距
              childAspectRatio: 1.2, //item 宽高比
            ),
          )
        ],
      ),
    );
  }

  _thirdBuildView() {
    return GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          pattern: [
            WovenGridTile(1.2),
            WovenGridTile(1.2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          if (index > widget.bannerList.length) return null;
          return VideoCard(
            videoData: widget.bannerList[index],
            valueChanged: (videoModel) {
              print("点击 ${videoModel}");
              HiNavigator.getInstance()
                  .onJumpTo(RouteStatus.detail, args: videoModel);
            },
          );
        }));
  }

  _forthBuildView() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return VideoCard(
          videoData: widget.bannerList[index],
          valueChanged: (videoModel) {
            print("点击 ${videoModel}");
            HiNavigator.getInstance()
                .onJumpTo(RouteStatus.detail, args: videoModel);
          },
        );
      },
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: widget.bannerList.length,
    );
  }

  _forthBuildSecondView() {
    // return HiNestedScrollView
    return HiNestedScrollView(
      headers: [
        if (!widget.bannerList.isEmpty) _banner(),
        SizedBox(height: 10)
      ],
      itemCount: widget.bannerList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.2),
      itemBuilder: (BuildContext context, int index) {
        return VideoCard(
          videoData: widget.bannerList[index],
          valueChanged: (videoModel) {
            print("点击 ${videoModel}");
            HiNavigator.getInstance()
                .onJumpTo(RouteStatus.detail, args: videoModel);
          },
        );
      },
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
            mainAxisCellCount: 0.8,
            child: VideoCard(
              videoData: element,
              valueChanged: (videoModel) {
                print("点击 ${videoModel}");
                HiNavigator.getInstance()
                    .onJumpTo(RouteStatus.detail, args: videoModel);
              },
            )));
      });
    }

    return li;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent = 165;
  final double _maxExtent = 165;

  final List<VideoData> bannerList;

  _MySliverPersistentHeaderDelegate(this.bannerList);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //创建child子组件
    //shrinkOffset：child偏移值minExtent~maxExtent
    //overlapsContent：SliverPersistentHeader覆盖其他子组件返回true，否则返回false
    print('shrinkOffset = $shrinkOffset overlapsContent = $overlapsContent');
    return HiBanner(
      bannerList,
      valueChanged: (videoModel) {
        print("点击：${videoModel}");
      },
    );
  }

  //SliverPersistentHeader最大高度
  @override
  double get maxExtent => _maxExtent;

  //SliverPersistentHeader最小高度
  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
