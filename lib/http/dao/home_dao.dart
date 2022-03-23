import 'package:blibli/http/request/video_detail_request.dart';
import 'package:blibli/http/request/video_play_request.dart';
import 'package:blibli/model/video_detail_model.dart';
import 'package:blibli/model/video_play_model.dart';

import '../../model/video_data_model.dart';
import '../core/hi_net.dart';
import '../request/home_request.dart';

class HomeDao {
  static get() async {
    var request = HomeRequest();
    request.add("rid", 1);
    var result = await HiNet.getInstance().fire(request);

    var videoModel = VideoDataModel.fromJson(result);

    return videoModel;
  }

  static detailGet(String aid, String bvid) async {
    var request = VideoDetailRequest();
    request.add("aid", aid).add("bvid", bvid);
    var result = await HiNet.getInstance().fire(request);

    var detailModel = VideoDetailModel.fromJson(result);

    return detailModel;
  }

  static videoPlayGet(int avid, int cid) async {
    var request = VideoPlayRequest();
    // qn=16&type=mp4&platform=html5
    request
        .add("avid", avid)
        .add("cid", cid)
        .add("qn", 16)
        .add("type", "mp4")
        .add("platform", "html5");
    var result = await HiNet.getInstance().fire(request);

    var model = VideoPlayModel.fromJson(result);

    return model;
  }
}
