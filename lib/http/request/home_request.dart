import 'package:blibli/http/request/base_request.dart';

class HomeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.Get;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "x/web-interface/ranking/region";
  }

  @override
  String authority() {
    return "api.bilibili.com";
  }
}
