import 'package:swustflutter/db/search_history_provider.dart';
import 'package:swustflutter/logic/file_store.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/model/search_history.dart';
import 'package:swustflutter/pages/detail_info.dart';
import 'package:swustflutter/widgets/find_list.dart';
import 'package:swustflutter/widgets/search_history.dart';
import 'package:swustflutter/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/config/constant.dart';
import '../../client/swust_api_client.dart';



class SearchPage extends StatefulWidget {
  ///搜索历史
  SearchHistoryProvider searchHistoryProvider = SearchHistoryProvider();///历史记录

  ExperStore experStore;

  SearchPage();

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

enum SearchState { typing, loading, done, empty, fail }

class SearchPageState extends State<SearchPage> {
  var _historyWords = List<SearchHistory>();
  var _searchKeyWord;
  var _searchState = SearchState.typing;

  ///搜索结果实验室列表
  List<dynamic> _searchResult = [];
  SwustAPIClient apiClient = new SwustAPIClient();

  Future<List<dynamic>> _searchKeyword(String value) async {
    return await apiClient.getSearchList(Constant.userConfigInfo.authtoken, value);
  }

  ///搜索历史的插入与移除
  void _onSearchHistoryEvent(SearchHistoryEvent event, SearchHistory history) {
    switch (event) {
      case SearchHistoryEvent.insert:
        widget.searchHistoryProvider
            .insert(history)
            .then((onValue) => setState(() {
                  history.id = onValue;
                  _historyWords.insert(0, history);
                }))
            .catchError((e) {});
        break;
      case SearchHistoryEvent.delete:
        widget.searchHistoryProvider
            .deleteById(history?.id)
            .then((value) => setState(() => _historyWords.remove(history)));
        break;
      case SearchHistoryEvent.clear:
        widget.searchHistoryProvider
            .deleteAll()
            .then((value) => setState(() => _historyWords.clear()));
        break;
      case SearchHistoryEvent.search:
        _onSubmittedSearchWord(history.keyword);
        break;
    }
  }

  @override
  void initState() {
    widget.searchHistoryProvider
        .query()
        .then((list) => setState(() => _historyWords = list));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            _buildSerachInput(),
            Container(height: 15),
            _buildPageBody(),
          ],
        ),
      ),
    );
  }

  ///展示搜索状态
  Widget _buildPageBody() {
    switch (_searchState) {
      case SearchState.typing:
        return _buildSearchHistory();
      case SearchState.loading:
        return _buildLoadingWidget();
      case SearchState.done:
        return _buildSearchResult();
      case SearchState.fail:
      case SearchState.empty:
        return null;
    }
  }

  ///提交关键词，进行搜索处理
  void _onSubmittedSearchWord(String value) {
    value = value.trim();
    if (value.isEmpty) return;

    setState(() => _searchState = SearchState.loading);///修改状态
    ///
    /// 在列表中查找实验室
    _searchKeyWord(value).then((result){
      setState(() {
        _searchState = SearchState.done;
        _searchResult = result;
      });
      ///保存搜索记录
      _onSearchHistoryEvent(SearchHistoryEvent.insert, SearchHistory(value));
    });

    return ;
  }

  void _onOpenFile(String labId) {
      /// 跳转到实验室详情界面
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                DetailInfo(experimentInfo: experimentInfo)));
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      _searchKeyWord = value.trim();
      _searchState = SearchState.typing;
    });
  }

  Widget _buildSearchHistory() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('搜索历史',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600))
            ],
          ),
          Expanded(
              child: SearchHistoryWidget(
            _historyWords,
            searchKeyWord: _searchKeyWord,
            eventCallback: _onSearchHistoryEvent,
          ))
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      heightFactor: 6,
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(strokeWidth: 4.0),
          Text('正在搜索')
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('搜索结果(${_searchResult.length})',
                  style: TextStyle(color: Colors.black, fontSize: 12))
            ],
          ),
          Expanded(
              child: ExperimentListWidget(
            _searchResult,
            onFileTap: _onOpenFile,
          ))
        ],
      ),
    );
  }

  ///搜索输入框
  Widget _buildSerachInput() {
    return Container(
      height: 35,
      child: Row(
        children: <Widget>[
          Expanded(
              child: SearchInputWidget(
            onSubmitted: _onSubmittedSearchWord,
            onTextChanged: _onSearchTextChanged,
          )),
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: FlatButton(
              child: new Text('取消', style: TextStyle(color: Colors.blue, fontSize: 14)),
              onPressed: () => setState(() => Navigator.of(context).pop()),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            ),
          ),
        ],
      ),
    );
  }
}
