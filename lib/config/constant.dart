import 'package:swustflutter/config/user_config.dart';
import 'package:swustflutter/model/user_info.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Constant {
  static const String userAccount = 'UserAccount';
  static const String userPassword = 'UserPassword';

  static const String dbName = 'swust.db';
  static const int dbVersion = 1;
  static const String searchHistoryTable = 'search_history';

  /// Android Q api 29 开始Android系统使用沙盒，无法直接获取存储卡目录。
  ///
  /// 使用getExternalStorageDirectory 返回如：
  /// /storage/emulated/0/Android/data/cn.edu.swust.bddisk/files
  static const String defaultExternalStorageDirectoryPrefix = '/Android/data/';

  static UserConfig userConfigInfo;
  static UserInfo userInfo;
  static const baseUrl = 'http://81.70.222.171:80';

  static void useFlush(String msg, BuildContext context) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: "${msg}",
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}
