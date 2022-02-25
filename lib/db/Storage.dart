import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static Future setString(key,value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }


  static Future<String?> getString(key) async {

    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(key);

  }

  static Future remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.remove(key);
  }

  static Future clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.clear();
  }



}