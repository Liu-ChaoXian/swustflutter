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
}