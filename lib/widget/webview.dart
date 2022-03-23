import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebView extends StatelessWidget {
  final String url;
  final double? aspectRatio;
  const HiWebView(this.url, {Key? key, this.aspectRatio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contSize = MediaQuery.of(context).size;
    double screenWidth = contSize.width;
    return Container(
      width: screenWidth,
      height: this.aspectRatio != null
          ? screenWidth / this.aspectRatio!
          : double.infinity,
      color: Colors.red,
      child: WebView(
        initialUrl: this.url,
        onWebViewCreated: (WebViewController webViewController) {
          print("webview create");
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ),
    );
  }
}
