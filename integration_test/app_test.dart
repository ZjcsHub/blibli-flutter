import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:blibli/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Test login jump", (WidgetTester tester) async {
    // 启动我们的APP
    app.main();
    // 捕获一帧
    await tester.pumpAndSettle();
    // 通过key查找注册按钮
    var registrationBtn = find.byKey(Key('registrationBtn'));
    // 触发点击
    await tester.tap(registrationBtn);
    // 捕获一帧
    await tester.pumpAndSettle();
    // 等待3s
    await Future.delayed(Duration(seconds: 3));
  });
}
