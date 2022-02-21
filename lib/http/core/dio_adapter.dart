import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/request/base_request.dart';
import 'package:dio/dio.dart';

import '../core/hi_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, option = Options(headers: request.header);
    var error;
    try {
      switch (request.httpMethod()) {
        case HttpMethod.Get:
          response = await Dio().get(request.url(), options: option);
          break;
        case HttpMethod.POST:
          response = await Dio()
              .post(request.url(), options: option, data: request.params);
          break;
        case HttpMethod.DELETE:
          response = await Dio()
              .delete(request.url(), options: option, data: request.params);
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  /// 构建HiNetResponse
  buildRes(Response response, BaseRequest request) {
    return HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
