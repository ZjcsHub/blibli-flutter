/// 可展开的widget
import 'package:blibli/model/video_detail_model.dart';
import 'package:blibli/util/formater_util.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class ExpandableContent extends StatefulWidget {
  final VideoDetailModel detailModel;

  const ExpandableContent(this.detailModel, {Key? key}) : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false;
  // 管理动画
  AnimationController? _controller;
  // 生成动画高度的值
  Animation<double>? _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _heightFactor = _controller?.drive(_easeInTween);
    _controller?.addListener(() {
      print("监听动画值的变化${_heightFactor?.value}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          _buildInfo(),
          _buildDesc()
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent, // 透明色
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 通过Expanded让text获得最大宽度
          Expanded(
              child: Text(
            widget.detailModel.data?.view?.title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(_expand
              ? Icons.keyboard_arrow_up_sharp
              : Icons.keyboard_arrow_down_sharp)
        ],
      ),
    );
  }

  _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        // 执行动画
        _controller?.forward();
      } else {
        // 反向执行
        _controller?.reverse();
      }
    });
  }

  _buildInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var time = widget.detailModel.data?.view?.ctime ?? 0;
    var dateFormater = formatDate(
        DateTime.fromMillisecondsSinceEpoch(time * 1000),
        [yyyy, '/', mm, '/', dd]);
    var viewsCounts =
        countFormat(widget.detailModel.data?.view?.stat?.view ?? 0);
    var reply = countFormat(widget.detailModel.data?.view?.stat?.reply ?? 0);
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, viewsCounts),
        Padding(padding: EdgeInsets.only(left: 5)),
        ...smallIconText(Icons.list_alt, reply),
        Padding(padding: EdgeInsets.only(left: 5)),
        Text(
          dateFormater,
          style: style,
        )
      ],
    );
  }

  _buildDesc() {
    var child = _expand
        ? Text(
            widget.detailModel.data?.view?.desc ?? "",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;
    return AnimatedBuilder(
      animation: _controller!.view,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor!.value,
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
