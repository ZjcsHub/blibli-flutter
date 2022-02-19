enum HttpMethod { Get, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams;

  var useHttps = true;

  String authority() {
    return "api.devio.org";
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
    return url.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  // 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();
  // 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
