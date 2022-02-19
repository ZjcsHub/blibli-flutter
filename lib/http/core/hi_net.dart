import 'package:blibli/http/core/hi_adapter.dart';
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/mock_adapter.dart';
import 'package:blibli/http/request/base_request.dart';

class HiNet {
  static HiNet? _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response.data;
    printLog(result);

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status!, result.toString());
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog("url:${request.url()}");
    printLog("method:${request.httpMethod()}");
    request.addHeader("token", "123");
    printLog("header:${request.header}");

    HiNetAdapter adapter = MockAdapter();

    return adapter.send(request);
  }

  void printLog(log) {
    print("hi_net:${log.toString()}");
  }
}
