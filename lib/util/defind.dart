import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HiDefend {
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.current);
      } else {
        // 开发期间
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, _reportError);
  }

  /// 通过接口上报
  _reportError(Object e, StackTrace s) {
    if (kReleaseMode == false) {
      print("catch error : $e");
    }
  }
}
