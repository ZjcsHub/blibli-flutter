import '../request/base_request.dart';

class TestRequest extends BaseRequest {
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
    return "uapi/test/test";
  }
}
