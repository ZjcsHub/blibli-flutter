import 'package:blibli/http/core/hi_adapter.dart';
import 'package:blibli/http/request/base_request.dart';

/// 测试适配器，mock数据

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(
        Duration(seconds: 2),
        () => HiNetResponse(
              statusCode: 200,
              data: {
                "statusCode": 200,
                "data": {"code": 0, "message": "success"}
              },
            ));
  }
}
