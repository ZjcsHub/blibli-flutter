import 'package:blibli/widget/appbar.dart';
import 'package:flutter/material.dart';

import '../widget/login_effect.dart';
import '../widget/login_input.dart';
import '../widget/mybutton.dart';
import '../widget/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _focus = false;
  String userName = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        "密码登录",
        "注册",
        () {},
      ),
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
