import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const LoginButton(this.title, {Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 45,
        onPressed: onPressed,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
