import 'package:flutter/material.dart';

import '../widget/appbar.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("right button click");
      }),
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
                onChanged: (text) {},
                lineStretch: true),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {},
              focusChanged: (focus) {
                setState(() {
                  this._focus = focus;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
