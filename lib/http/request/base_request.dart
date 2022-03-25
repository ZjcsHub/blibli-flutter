import 'package:blibli/http/dao/login_dao.dart';

enum HttpMethod { Get, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams;

  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  bool responseJson() {
    return true;
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri url;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http 和 https 切换
    if (useHttps) {
      url = Uri.https(authority(), pathStr, params);
    } else {
      url = Uri.http(authority(), pathStr, params);
    }

    if (needLogin()) {
      // 需要给登录接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }

    return url.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  // 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {
    "course-flag": "fa",
    "auth-token": "MjAyMC0wNi0yMyAwMzonyNtowMQ==fa"
  };
  // 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
