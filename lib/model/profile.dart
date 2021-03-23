class Profile {
  String userAccount;
  String userAvatarUrl;
  String userClass;
  String userEmail;
  String userName;
  String userPhone;
  String token;
  int userType;

  Profile(
      {this.userAccount,
      this.userAvatarUrl,
      this.userClass,
      this.userEmail,
      this.userName,
      this.userPhone,
      this.token,
      this.userType});

  Profile.fromJson(Map<String, dynamic> json) {
    userAccount = json['userAccount'];
    userAvatarUrl = json['userAvatarUrl'];
    userClass = json['userClass'];
    userEmail = json['userEmail'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    token = json['token'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userAccount'] = this.userAccount;
    data['userAvatarUrl'] = this.userAvatarUrl;
    data['userClass'] = this.userClass;
    data['userEmail'] = this.userEmail;
    data['userName'] = this.userName;
    data['userPhone'] = this.userPhone;
    data['token'] = this..token;
    data['userType'] = this.userType;
    return data;
  }
}
