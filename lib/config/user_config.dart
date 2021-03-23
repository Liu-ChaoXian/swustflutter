class UserConfig {
  /// token 信息
  String authtoken;
  /// 用户类型
  int userType;

  UserConfig(this.authtoken, this.userType);

  UserConfig.fromJson(Map<String, dynamic> json){
    this.authtoken = json['authtoken'];
    this.userType = json['userType'];
  }
}