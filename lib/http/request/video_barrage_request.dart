import 'home_request.dart';

class VideoBarrageRequest extends HomeRequest {
  @override
  String path() {
    return "x/v1/dm/list.so";
  }

  @override
  bool responseJson() {
    // TODO: implement responseJson
    return false;
  }
}
