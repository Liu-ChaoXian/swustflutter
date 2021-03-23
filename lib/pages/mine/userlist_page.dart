import 'dart:io';
import 'package:swustflutter/common/SwustApi.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/model/user_info.dart';
import 'package:swustflutter/pages/detail_info.dart';
import 'package:swustflutter/pages/find/search_page.dart';
import 'package:swustflutter/widgets/find_list.dart';
import 'package:swustflutter/widgets/search_input.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/widgets/user_list.dart';

class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListState();
}

///查找状态
enum UserListState { loading, loaded, fail }

class _UserListState extends State<UserListPage> {
  UserListState _filesState = UserListState.loaded;
  List users;

  ///用户列表

  _getList() async {
    // return await SwustApi().Get('获取实验室成员', '');
  }

  @override
  void initState() {
    super.initState();
    users = [
      {"memberId": "5120173553", "memberName": "LiuChaoXian"},
      {"memberId": "5120173554", "memberName": "LiuChaoXian"},
      {"memberId": "5120173555", "memberName": "LiuChaoXian"},
      {"memberId": "5120173553", "memberName": "LiuChaoXian"},
      {"memberId": "5120173554", "memberName": "LiuChaoXian"},
      {"memberId": "5120173555", "memberName": "LiuChaoXian"},
      {"memberId": "5120173553", "memberName": "LiuChaoXian"},
      {"memberId": "5120173554", "memberName": "LiuChaoXian"},
      {"memberId": "5120173555", "memberName": "LiuChaoXian"},
      {"memberId": "5120173553", "memberName": "LiuChaoXian"},
      {"memberId": "5120173554", "memberName": "LiuChaoXian"},
      {"memberId": "5120173555", "memberName": "LiuChaoXian"}
    ];
  }

  ///实验室界面
  Widget _buildExperWidget() {
    switch (_filesState) {
      case UserListState.loading:

        ///加载中
        return Column(children: <Widget>[
          SizedBox(height: 200),
          CircularProgressIndicator(strokeWidth: 4.0),
          Text('正在加载')
        ]);
      case UserListState.loaded:
        return UserListWidget(users);
      case UserListState.fail:

        ///加载失败
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
        title: Text('实验室成员', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            Center(child: _buildExperWidget())
          ],
        ),
      ),
    );
  }
}
