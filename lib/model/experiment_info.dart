///实验室信息

class ExperimentInfo{

  ///实验室名称
  String experimentName;

  ///实验室ID (六位整数)
  int experimentID;

  ///实验室地址
  String experimentAddress;

  ///实验室负责人
  String director;

  ///实验室简介
  String detailInfo;

  ///图片信息  可以保存多张图片
  List<String> imageLink;

  ///实验室成果
  String achievement;

  ///实验室招新时间
  String time;

  /// 申请人ID
  String applicantId;

  /// 联系方式
  String labContact;

  /// 实验室ID
  String labId;

  ///实验室头像
  String labAvatarUrl;

  ExperimentInfo({
    this.experimentName,
    this.experimentID,
    this.experimentAddress,
    this.director,
    this.detailInfo,
    this.imageLink,
    this.achievement,
    this.time
  });

  String getName(){
    return this.experimentName;
  }

  ExperimentInfo.fromJson(Map<String, dynamic> json){
    this.applicantId = json['applicantId'];
    this.director = json['applicantName'];
    this.labContact = json['labContact'];
    this.detailInfo = json['labIntro'];
    this.experimentName = json['labName'];
    this.labId = json['labId'];
    this.achievement = json['labHonor'];
    this.experimentAddress = json['labAddr'];
  }
  ExperimentInfo.fromJsonDefault(Map<String, dynamic> json){
    this.labAvatarUrl = json['labAvatarUrl'];
    this.director = json['labManagerName'];
    this.labContact = json['labContact'];
    this.experimentName = json['labName'];
    this.labId = json['labId'];
  }
}