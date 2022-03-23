import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'ranking_favorite_page.dart';
import 'ranking_hot_page.dart';
import 'ranking_like_page.dart';
import '../internationalization/Internation.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [_appBar(), _bodyView()],
    ));
  }

  _appBar() {
    return NavigationBar(
      child: Center(
        child: HiTab(
          [
            Tab(
              child: Text(Internation.getInstance().Like(context)),
            ),
            Tab(
              child: Text(Internation.getInstance().Hot(context)),
            ),
            Tab(
              child: Text(Internation.getInstance().Favorite(context)),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  _bodyView() {
    return Flexible(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          RankingLikePage(),
          RankingHotPage(),
          RankingFavoritePage()
          // ,
        ],
      ),
    );
  }
}
