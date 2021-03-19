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
      detailInfo: '软件测试实验是一个很棒的实验室！！！软件测试实验是一个很棒的实验室！！！',
      director: '潘娅',
      imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
      achievement: '各类比赛斩获佳绩',
      time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '移动互联网实验室',
        experimentID: 2,
        experimentAddress: '东九A240',
        detailInfo: '移动互联网实验是一个很棒的实验室！！！',
        director: '李从磊',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '数据与知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '数据与知识工程实验室是一个从事前后端开发和数据处理的实验室，拥有颇多成果'
            '（(SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等)，每年实验室都有'
            '入职bat的学长学姐。加入我们，你将不会后悔自己的选择，数据与知识工程实验室期待你的加入!'
            '前端:前端技术一般分为前端设计和前端开发，前端设计可以理解为网站的视觉设计,前端开发则是'
            '网站的前台代码实现,包括基本的HTML和CSS以及javascript后端:后端开发一般也叫做后台,其负'
            '责是网站后台逻辑的设计和实现还有用户及网站的数据的保存和读取。'
            '数据:数据分析是指用适当的编程语言来收集数据,进行统计分析放大对收集来的达两数据进行分'
            '析,将他们加以汇总和理解并消化,以求最大化的开发数据的作用。',
        director: '杨春明',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: 'SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '软件测试实验室',
        experimentID: 1,
        experimentAddress: '东九A238',
        detailInfo: '软件测试实验是一个很棒的实验室！！！软件测试实验是一个很棒的实验室！！！',
        director: '潘娅',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '移动互联网实验室',
        experimentID: 2,
        experimentAddress: '东九A240',
        detailInfo: '移动互联网实验是一个很棒的实验室！！！',
        director: '李从磊',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '数据与知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '数据与知识工程实验室是一个从事前后端开发和数据处理的实验室，拥有颇多成果'
            '（(SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等)，每年实验室都有'
            '入职bat的学长学姐。加入我们，你将不会后悔自己的选择，数据与知识工程实验室期待你的加入!'
            '前端:前端技术一般分为前端设计和前端开发，前端设计可以理解为网站的视觉设计,前端开发则是'
            '网站的前台代码实现,包括基本的HTML和CSS以及javascript后端:后端开发一般也叫做后台,其负'
            '责是网站后台逻辑的设计和实现还有用户及网站的数据的保存和读取。'
            '数据:数据分析是指用适当的编程语言来收集数据,进行统计分析放大对收集来的达两数据进行分'
            '析,将他们加以汇总和理解并消化,以求最大化的开发数据的作用。',
        director: '杨春明',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: 'SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '软件测试实验室',
        experimentID: 1,
        experimentAddress: '东九A238',
        detailInfo: '软件测试实验是一个很棒的实验室！！！软件测试实验是一个很棒的实验室！！！',
        director: '潘娅',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '移动互联网实验室',
        experimentID: 2,
        experimentAddress: '东九A240',
        detailInfo: '移动互联网实验是一个很棒的实验室！！！',
        director: '李从磊',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '数据与知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '数据与知识工程实验室是一个从事前后端开发和数据处理的实验室，拥有颇多成果'
            '（(SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等)，每年实验室都有'
            '入职bat的学长学姐。加入我们，你将不会后悔自己的选择，数据与知识工程实验室期待你的加入!'
            '前端:前端技术一般分为前端设计和前端开发，前端设计可以理解为网站的视觉设计,前端开发则是'
            '网站的前台代码实现,包括基本的HTML和CSS以及javascript后端:后端开发一般也叫做后台,其负'
            '责是网站后台逻辑的设计和实现还有用户及网站的数据的保存和读取。'
            '数据:数据分析是指用适当的编程语言来收集数据,进行统计分析放大对收集来的达两数据进行分'
            '析,将他们加以汇总和理解并消化,以求最大化的开发数据的作用。',
        director: '杨春明',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: 'SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '软件测试实验室',
        experimentID: 1,
        experimentAddress: '东九A238',
        detailInfo: '软件测试实验是一个很棒的实验室！！！软件测试实验是一个很棒的实验室！！！',
        director: '潘娅',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '移动互联网实验室',
        experimentID: 2,
        experimentAddress: '东九A240',
        detailInfo: '移动互联网实验是一个很棒的实验室！！！',
        director: '李从磊',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: '各类比赛斩获佳绩',
        time: '每年6月份'
    ),
    ExperimentInfo(
        experimentName: '数据与知识工程实验室',
        experimentID: 3,
        experimentAddress: '东九A236',
        detailInfo: '数据与知识工程实验室是一个从事前后端开发和数据处理的实验室，拥有颇多成果'
            '（(SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等)，每年实验室都有'
            '入职bat的学长学姐。加入我们，你将不会后悔自己的选择，数据与知识工程实验室期待你的加入!'
            '前端:前端技术一般分为前端设计和前端开发，前端设计可以理解为网站的视觉设计,前端开发则是'
            '网站的前台代码实现,包括基本的HTML和CSS以及javascript后端:后端开发一般也叫做后台,其负'
            '责是网站后台逻辑的设计和实现还有用户及网站的数据的保存和读取。'
            '数据:数据分析是指用适当的编程语言来收集数据,进行统计分析放大对收集来的达两数据进行分'
            '析,将他们加以汇总和理解并消化,以求最大化的开发数据的作用。',
        director: '杨春明',
        imageLink: ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'],
        achievement: 'SWUST Online Judge, isearch舆情监测平台等，卓越班招新系统等',
        time: '每年6月份'
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
