import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? clickCallBack;

  final String title;

  final Color color;

  final Color textColor;

  const MyButton(
    this.title, {
    Key? key,
    this.clickCallBack,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickCallBack,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(color: this.textColor, fontSize: 17),
          ),
        ),
        margin: EdgeInsets.all(20),
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
