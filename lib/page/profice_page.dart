import 'package:flutter/material.dart';

class ProficePage extends StatefulWidget {
  const ProficePage({Key? key}) : super(key: key);

  @override
  _ProficePageState createState() => _ProficePageState();
}

class _ProficePageState extends State<ProficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("我的"),
      ),
    );
  }
}
