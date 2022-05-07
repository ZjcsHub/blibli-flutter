import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/widget/appbar.dart';
import 'package:flutter/material.dart';

import '../http/dao/login_dao.dart';
import '../widget/login_button.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _focus = false;
  String userName = "";
  String password = "";

  send() {
    // try {
    //   var result = LoginDao.login(userName, password);
    //   if (result["code"] == 0) {
    //     print("登录成功");
    //
    //     HiNavigator.getInstance().onJumpTo(RouteStatus.home);
    //   } else {
    //     print(result['msg']);
    //   }
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on HiNetError catch (e) {
    //   print(e);
    // }
    print("username:$userName,password:$password");
    var result = LoginDao.login(userName, password) as Map;
    print("result:$result");
    if (result["code"] == 0) {
      print("登录成功");

      HiNavigator.getInstance().onJumpTo(RouteStatus.home);
    } else {
      print(result['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }, key: Key("registrationBtn")),
      body: Container(
        child: ListView(
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
              },
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: LoginButton(
                "登录",
                onPressed: () {
                  print("登录");
                  send();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
