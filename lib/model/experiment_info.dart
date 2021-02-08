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

  ///详细信息
  String detailInfo;

  ///图片信息
  String imageLink;

  ExperimentInfo({
    this.experimentName,
    this.experimentID,
    this.experimentAddress,
    this.director,
    this.detailInfo,
    this.imageLink,
  });

  String getName(){
    return this.experimentName;
  }
}