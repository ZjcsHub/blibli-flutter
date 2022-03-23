import 'package:blibli/EventBus/event_notification.dart';
import 'package:blibli/core/hi_state.dart';
import 'package:blibli/http/dao/home_dao.dart';
import 'package:blibli/model/video_data_model.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/home_recommend_page.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  var listener;

  TabController? _controller;

  final List<Map> _tabValues = [
    {
      "title": '推荐',
      "vc": HomeRecommendPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    // 生命周期
    WidgetsBinding.instance?.addObserver(this);
    this.listener = (RouteStatesInfo current, RouteStatesInfo? pre) {
      print("current:${current.page}");
      print("pre:${pre?.page}");

      if (widget == current.page || current.page is HomePage) {
        print("打开了首页， onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页：onPause");
      }
    };
    HiNavigator.getInstance().addListener(this.listener);
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );

    _getData();
  }

  _getData() async {
    try {
      var result = await HomeDao.get();
      if (result is VideoDataModel) {
        var videoDataLists = (result as VideoDataModel).data;

        var homePage = _tabValues
            .firstWhere((element) => element["vc"] is HomeRecommendPage);

        if (homePage != null) {
          var homePageVc = homePage["vc"] as HomeRecommendPage;
          print("videoDataLists:$videoDataLists");
          // setState(() {
          //   homePageVc.bannerList = videoDataLists ?? [];
          // });
          // 两个不同的widget需要用到通知
          eventBus.fire(HomePageChangeEvent(videoDataLists ?? []));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
    _controller?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("生命周期变化:$state");
    switch (state) {
      case AppLifecycleState.inactive:
        // 应用程序可能会被暂停
        break;
      case AppLifecycleState.resumed:
        // 从后台切换到前台，应用可见
        break;
      case AppLifecycleState.detached:
        // 页面不可见，后台
        break;
      case AppLifecycleState.paused:
        //APP结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        NavigationBar(
          child: _appBar(),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          child: HiTab(
            _tabValues.map((e) => Text(e["title"] as String)).toList(),
            controller: _controller,
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _controller,
            children: _tabValues.map((e) => e["vc"] as Widget).toList(),
          ),
        )
      ],
    ));
  }

  _appBar() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("点击");
              HiNavigator.getInstance().onJumpTo(RouteStatus.login);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("images/left_eys_open.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          GestureDetector(
            onTap: () {
              print("点击explore_outlined");
            },
            child: Icon(Icons.explore_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                print("点击mail_outline");
              },
              child: Icon(Icons.mail_outline, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
