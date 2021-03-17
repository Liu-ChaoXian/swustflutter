import 'dart:io';

import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/pages/detail_info.dart';
import 'package:swustflutter/pages/search_page.dart';
import 'package:swustflutter/widgets/find_list.dart';
import 'package:swustflutter/widgets/search_input.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {///发现界面

  @override
  State<StatefulWidget> createState() => _FindPageState();
}

///查找状态
enum FindState { loading, loaded, fail }

class _FindPageState extends State<FindPage>{

  List<ExperimentInfo> _exper = [];
  FindState _filesState = FindState.loaded;

  ///实验室列表
  final _experimentList = [
    ExperimentInfo(
      experimentName: '软件测试实验室',
      experimentID: 1,
      experimentAddress: '东九A238',
      detailInfo: '软件测试实验是一个很棒的实验室！！！',
      director: '潘娅',
      imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '移动互联网实验室',
        experimentID: 2,
        experimentAddress: '东九A240',
        detailInfo: '移动互联网实验是一个很棒的实验室！！！',
        director: '李从磊',
        imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '知识工程实验是一个很棒的实验室！！！',
        director: '杨春明',
        imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '知识工程实验是一个很棒的实验室！！！',
        director: '杨春明',
        imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '知识工程实验是一个很棒的实验室！！！',
        director: '杨春明',
        imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '知识工程实验是一个很棒的实验室！！！',
        director: '杨春明',
        imageLink: 'assets/logo.jpg'
    ),
    ExperimentInfo(
        experimentName: '知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '知识工程实验是一个很棒的实验室！！！',
        director: '杨春明',
        imageLink: 'assets/logo.jpg'
    ),
  ];

  @override
  void initState() {
    super.initState();
    _exper = _experimentList;
  }

  ///聚焦搜索框
  void _onFocusSearchInput() {
   Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SearchPage(_exper)));
  }

  ///跳转到实验室详细信息界面
  void _onForwardDir(ExperimentInfo experimentInfo){
      Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>
                DetailInfo(experimentInfo: experimentInfo)));
  }

  ///实验室界面
  Widget _buildExperWidget() {
    switch (_filesState) {
      case FindState.loading:///加载中
        return Column(children: <Widget>[
          SizedBox(height: 200),
          CircularProgressIndicator(strokeWidth: 4.0),
          Text('正在加载')
        ]);
      case FindState.loaded:
        return ExperimentListWidget(_exper, onFileTap: _onForwardDir);
      case FindState.fail:///加载失败
        return Column(children: <Widget>[
          SizedBox(height: 200),
          /*IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 96,
              onPressed: _requestFiles),
          Text(_failMsg)*/
        ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('实验室信息', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: <Widget>[
            Container(
                height: 35,
                child: SearchInputWidget(onTap: _onFocusSearchInput)),
            Center(child: _buildExperWidget())
          ],
        ),
      ),
    );
  }
}
