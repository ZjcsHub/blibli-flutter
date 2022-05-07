// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void showWarningToast(String text) {
  SmartDialog.showToast(
    "",
    widget: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}

void showToast(String text) {
  SmartDialog.showToast(text);
}
