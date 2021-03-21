import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/model/profile.dart';
import 'package:swustflutter/common/Swust.dart';

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    //初始化网络请求相关配置
    Swust.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
