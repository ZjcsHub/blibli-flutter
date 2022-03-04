import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/util/string_util.dart';
import 'package:blibli/util/toast.dart';
import 'package:flutter/material.dart';

import '../http/dao/login_dao.dart';
import '../widget/appbar.dart';
import '../widget/login_button.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _focus = false;
  bool loginEnable = false;

  String userName = "";
  String password = "";
  String rePaddword = "";
  String impocId = "";
  String orderId = "";

  _loginButton() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: LoginButton(
        "注册",
        onPressed: checkParams,
      ),
    );
  }

  checkParams() {
    var registerEffective = checkInput();
    if (registerEffective == false) {
      print("请填写完完整信息");
      showWarningToast("请填写完完整信息");
      return;
    }
    String? tip;
    if (password != rePaddword) {
      tip = "两次密码不一致";
    } else if (orderId.length != 4) {
      tip = "请输入订单号后4位";
    }
    print(tip);
    if (tip == null) {
      send();
    } else {
      showWarningToast(tip);
    }
  }

  send() async {
    try {
      var result =
          await LoginDao.registration(userName, password, impocId, orderId);
      if (result["code"] == 0) {
        print("注册成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        print(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  checkInput() {
    var enable = isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePaddword) &&
        isNotEmpty(impocId) &&
        isNotEmpty(orderId);
    return enable;
  }

  _loginAction() {
    HiNavigator.getInstance().onJumpTo(RouteStatus.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", _loginAction),
      body: Container(
        child: ListView(
          // 自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(
              protext: _focus,
            ),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (text) {
                userName = text;
              },
              lineStretch: true,
              focusChanged: (focus) {
                if (focus == false) {
                  checkInput();
                }
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                password = text;
              },
              focusChanged: (focus) {
                setState(() {
                  this._focus = focus;
                });
                if (focus == false) {
                  checkInput();
                }
              },
            ),
            LoginInput(
              title: "确认密码",
              hint: "请确认密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                rePaddword = text;
              },
              focusChanged: (focus) {
                setState(() {
                  this._focus = focus;
                });
                if (focus == false) {
                  checkInput();
                }
              },
            ),
            LoginInput(
              title: "慕课网ID",
              hint: "请输入慕课网id",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                impocId = text;
              },
              focusChanged: (focus) {
                if (focus == false) {
                  checkInput();
                }
              },
            ),
            LoginInput(
              title: "订单id",
              hint: "请输入订单id",
              keyboardType: TextInputType.number,
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
              },
              focusChanged: (focus) {
                if (focus == false) {
                  checkInput();
                }
              },
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }
}
