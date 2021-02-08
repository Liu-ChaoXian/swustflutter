import 'package:swustflutter/logic/file_store.dart';
import 'package:swustflutter/model/experiment_info.dart';

class BdDiskFileStore extends ExperStore {

  Future<List<ExperimentInfo>> search(String value, {List<ExperimentInfo> store}) async{
    print('开始搜索！');
    var searchResult = List<ExperimentInfo>();
    for(int i=0;i<store.length;i++){
      String name = store[i].getName();
      if(name.contains(value)){
        print('搜索成功！'+value);
        searchResult.add(store[i]);///搜索结果
      }
      print('搜索失败！'+value);
    }
    return searchResult;
  }
}
