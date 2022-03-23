import '../generated/l10n.dart';
import 'package:flutter/material.dart';

class Internation {
  // 单利
  static Internation? _internation;
  static Internation getInstance() {
    if (_internation == null) {
      _internation = Internation();
    }
    return _internation!;
  }

  String Like(BuildContext context) {
    return S.of(context).ranking_like;
  }

  String Hot(BuildContext context) {
    return S.of(context).ranking_hot;
  }

  String Favorite(BuildContext context) {
    return S.of(context).ranking_favorite;
  }
}
