import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/model/search_history.dart';

import 'database_provider.dart';

class SearchHistoryProvider extends TableProvider<SearchHistory> {
  @override
  String get table => Constant.searchHistoryTable;

  @override
  Map<String, dynamic> toMap(SearchHistory t) {
    var map = <String, dynamic>{
      'keyword': t.keyword,
      'time': t.time ?? DateTime.now().millisecondsSinceEpoch,
    };

    if (t.id != null) {
      map['id'] = t.id;
    }
    return map;
  }

  @override
  SearchHistory fromMap(Map<String, dynamic> map) =>
      SearchHistory(map['keyword'], id: map['id'], time: map['time']);

  deleteById(int id) => super.delete(where: 'id = ?', whereArgs: [id]);
}
