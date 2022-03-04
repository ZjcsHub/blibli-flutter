import 'package:flutter/material.dart';

class HomeHotPage extends StatefulWidget {
  const HomeHotPage({Key? key}) : super(key: key);

  @override
  _HomeHotPageState createState() => _HomeHotPageState();
}

class _HomeHotPageState extends State<HomeHotPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("绘制 home_hot_page");
    return Container(
      child: Text("home_hot_page"),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
