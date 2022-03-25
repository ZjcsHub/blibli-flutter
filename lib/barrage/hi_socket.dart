import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HiSocket implements ISocket {
  static const _URL = "";

  IOWebSocketChannel? _channel;
  ValueChanged<List>? _callBack;

  /// 心跳间隔秒数
  int _intervalSecond = 50;

  @override
  void close() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }

  @override
  ISocket listen(ValueChanged<List> callBack) {
    _callBack = _callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSecond));
    _channel?.stream.handleError((error) {
      print("连接错误");
    }).listen((event) {
      _handleMessage(event);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  _headers() {
    Map<String, dynamic> header = {};
    return header;
  }

  _handleMessage(message) {
    print('received:$message');
    // 处理返回信息
  }
}

abstract class ISocket {
  /// 和服务器建立连接
  ISocket open(String vid);

  /// 发送弹幕
  ISocket send(String message);

  /// 关闭连接
  void close();

  /// 监听弹幕
  ISocket listen(ValueChanged<List> callBack);
}
