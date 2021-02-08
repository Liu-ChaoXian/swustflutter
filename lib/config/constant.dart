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
}
