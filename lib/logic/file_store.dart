import 'package:swustflutter/model/experiment_info.dart';


abstract class ExperStore {

  /// 搜索文件
  ///
  /// [value] 搜索关键字
  ///
  /// [store] 实验室库
  ///
  Future<List<ExperimentInfo>> search(String value, {List<ExperimentInfo> store});
}
