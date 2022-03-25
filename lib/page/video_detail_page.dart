import 'dart:convert';
import 'dart:io';
import 'package:blibli/barrage/hi_barrage.dart';
import 'package:blibli/http/dao/home_dao.dart';
import 'package:blibli/model/barrage_model.dart';
import 'package:blibli/model/video_detail_model.dart';
import 'package:blibli/model/video_play_model.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/widget/appbar.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigation_bar.dart';
import 'package:blibli/widget/video_header.dart';
import 'package:blibli/widget/video_large_card.dart';
import 'package:blibli/widget/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/video_data_model.dart';
import '../widget/video_view.dart';
import '../util/view_util.dart';
import '../widget/expandable_content.dart';
import '../widget/video_toolbar.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoData? videoModel;

  const VideoDetailPage({Key? key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  var listener;

  VideoDetailModel? _detailModel;
  VideoPlayModel? _playModel;

  TabController? _controller;
  List tabs = ["简介", "评论288"];
  List<BarrageModel>? barrageLists;

  var _barragekey = GlobalKey<HiBarrageState>();

  @override
  void initState() {
    super.initState();

    //初始化controller
    _controller = TabController(length: tabs.length, vsync: this);

    this.listener = (RouteStatesInfo current, RouteStatesInfo? pre) {
      print("current:${current.page}");
      print("pre:${pre?.page}");

      if (widget == pre?.page || pre?.page is VideoDetailPage) {
        print("videodetail：onPause");
        // 恢复nav
        setStatusBar(Colors.white, StatusStyle.Dark);
      }
    };
    HiNavigator.getInstance().addListener(this.listener);
    _asynData();
  }

  _asynData() async {
    try {
      var result = await HomeDao.detailGet(
          widget.videoModel?.aid ?? "", widget.videoModel?.bvid ?? "");
      if (result is VideoDetailModel) {
        _detailModel = result;
        setState(() {});
        _getVideoPlayData();
        _getBarrageData();
      }
    } catch (e) {
      print(e);
    }
  }

  _getVideoPlayData() async {
    try {
      var result = await HomeDao.videoPlayGet(
          _detailModel?.data?.view?.aid ?? 0,
          _detailModel?.data?.view?.cid ?? 0);
      if (result is VideoPlayModel) {
        setState(() {
          _playModel = result;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _getBarrageData() async {
    rootBundle.loadString("json/barrage.json").then((value) {
      List barrage = json.decode(value);
      print("state:${_barragekey.currentState}");
      setState(() {
        barrageLists = barrage
            .map((e) => BarrageModel(
                e, _detailModel?.data?.view?.cid.toString() ?? "", 3000))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Column(
              children: [
                // Text("视频详情页，vid：${widget.videoModel?.aid}"),
                // Text("视频详情页，title：${widget.videoModel?.title}"),

                NavigationBar(
                  color: Colors.black,
                  statusStyle: StatusStyle.Light,
                  height: Platform.isIOS ? 44 : 0,
                ),
                _videoView(),
                _tabNavigation(),
                Flexible(
                  child: TabBarView(
                    children: [
                      _buildDetailList(),
                      Container(
                        child: Text("敬请期待"),
                      )
                    ],
                    controller: _controller,
                  ),
                )
              ],
            )));
  }

  _videoView() {
    if (_playModel != null) {
      var barrageUi = HiBarrage(
        _playModel!.data?.videoCodecid?.toString() ?? "-1",
        key: _barragekey,
        barrageLists: barrageLists,
      );
      return VideoView(
        _playModel!.data?.durl?.first.url ?? "",
        // cover: widget.videoModel?.pic,
        overlayUi: videoAppBar(),
        barrageUi: barrageUi,
        pauseCallBack: () {
          _barragekey.currentState?.pause();
        },
        playCallBack: () {
          _barragekey.currentState?.play();
        },
      );
    } else {
      return Container(
        height: 200,
      );
    }

    // return HiWebView(
    //   "https://www.baidu.com",
    //   aspectRatio: 16.0 / 9.0,
    // );
  }

  _tabNavigation() {
    return Material(
      elevation: 5, //阴影大小
      shadowColor: Colors.grey[100], // 阴影颜色
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabbar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabbar() {
    return HiTab(
      tabs.map((e) {
        return Tab(
          text: e,
        );
      }).toList(),
      controller: _controller,
      fontSize: 15,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: buildContents(),
    );
  }

  buildContents() {
    var lists = [
      if (_detailModel != null) VideoHeader(_detailModel!.data!.view!.owner!),
      if (_detailModel != null) ExpandableContent(_detailModel!),
      if (_detailModel != null)
        VideoToolBar(
          _detailModel!,
          onCoin: _onCoin,
          onFavorite: _onFavorite,
          onLike: _onLike,
          onUnlike: _onUnlike,
          onShare: _onShare,
        ),
    ];
    if (_detailModel != null) {
      lists.addAll(_buildVideoList());
    }

    return lists;
  }

  _buildVideoList() {
    return _detailModel!.data?.related?.map((e) {
      return VideoLargeCard(
        videoData: VideoData.transFrom(e),
      );
    }).toList() as List<Widget>;
  }

  _onCoin() {
    print("_onCoin");
  }

  _onFavorite() {
    print("_onFavorite");
  }

  _onLike() {
    print("_onLike");
  }

  _onUnlike() {
    print("_onUnlike");
  }

  _onShare() {
    print("_onShare");
  }
}
