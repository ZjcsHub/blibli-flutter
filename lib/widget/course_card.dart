import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CourseCard extends StatelessWidget {
  final List<String>? courseList;

  const CourseCard({Key? key, this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildTitle(), _buildCardList(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
      child: Row(
        children: [
          Text(
            "职场进阶",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "带你突破技术瓶颈",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _getShowData(context),
    );
  }

  List<Widget> _getShowData(BuildContext context) {
    if (courseList == null) return [];

    return courseList?.map((e) {
      return StaggeredGridTile.count(
          crossAxisCellCount: 1, mainAxisCellCount: 0.7, child: cachedImage(e));
    }).toList() as List<Widget>;
  }
}
