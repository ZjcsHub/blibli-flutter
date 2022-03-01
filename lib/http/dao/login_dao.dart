// dao 用于数据操作
import 'package:blibli/db/hi_cache.dart';
import 'package:blibli/http/request/base_request.dart';
import 'package:blibli/http/request/login_request.dart';
import 'package:blibli/http/request/register_request.dart';

import '../../db/Storage.dart';
import '../core/hi_net.dart';

class LoginDao {
  static const String BOARDING_PASS = "boarding_pass";

  static login(String userName, String password) {
    _send(userName, password);
  }

  static registration(
      String userName, String password, String impocid, String orderId) {
    return _send(userName, password, impocid: impocid, orderid: orderId);
  }

  static _send(String userName, String password, {impocid, orderid}) async {
    BaseRequest request;
    if (impocid != null && orderid != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("impocId", impocid)
        .add("orderId", orderid);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().saveString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().getString(BOARDING_PASS);
  }
}
