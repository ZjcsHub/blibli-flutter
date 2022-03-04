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
}
