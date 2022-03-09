import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 带缓存的图片
Widget cachedImage(String url, {double width = 100, double height = 100}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
