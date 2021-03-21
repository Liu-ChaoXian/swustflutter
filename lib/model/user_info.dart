class UserInfo {///用户信息
  ///用户账号
  String userAccount;
  /// 用户名
  String userName;
  /// 头像地址
  String userAvatarUrl;
  /// 手机号
  String userPhone;
  /// 真实姓名 ？？
  String realName;
  /// 学号 ？？
  String studyID;
  /// 班级
  String userClass;
  /// 专业 ？？
  String major;
  /// 邮箱
  String userEmail;
  /// 用户类型
  int userType;

  UserInfo({
    this.userAccount,
    this.userName,
    this.userAvatarUrl,
    this.userPhone,
    this.realName,
    this.studyID,
    this.userClass,
    this.major,
    this.userEmail,
    this.userType
  });

  UserInfo.fromJson(Map<String, dynamic> json){
    this.userAccount = json['userAccount'];
    this.userName = json['userName'];
    this.userAvatarUrl = json['userAvatarUrl'];
    this.userPhone = json['userPhone'];
    this.userClass = json['userClass'];
    this.userEmail = json['userEmail'];
    this.userType = json['userType'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userAccount'] = this.userAccount;
    data['userName'] = this.userName;
    data['userAvatarUrl'] = this.userAvatarUrl;
    data['userPhone'] = this.userPhone;
    data['userClass'] = this.userClass;
    data['userEmail'] = this.userEmail;
    data['userType'] = this.userType;
    return data;
  }

}