import 'package:flutter/material.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/client/swust_api_client.dart';

import '../../client/swust_api_client.dart';
import '../../client/swust_api_client.dart';
class ChangeUserInfo extends StatefulWidget {
  @override
  _ChangeUserInfoState createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  /// 用户名称
  String newName;

  /// 用户联系方式
  String newPhone;

  /// 用户简介
  String newClass;

  /// 用户邮件
  String newEmail;

  SwustAPIClient apiClient = new SwustAPIClient();
  bool _isEnableLogin = false;
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  void _checkUserInput() {
    if (newName.isNotEmpty &&
        newPhone.isNotEmpty &&
        newClass.isNotEmpty && newEmail.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  Map<String, dynamic> paras = {};

  _editUserInfo(Map paras) async {
    return await apiClient.changeUserInfo(Constant.userConfigInfo.authtoken, paras);
  }

  _editButtonPressed(String token) {
    if (!_isEnableLogin) return null;

    return () {
      paras['newName'] = newName;
      paras['newPhone'] = newPhone;
      paras['newClass'] = newClass;
      paras['newEmail'] = newEmail;
      _editUserInfo(paras).then((value) {
        setState(() {
          Navigator.of(context).pop();
          Constant.useFlush(value['msg'], context);
        });
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('修改个人信息'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    newName = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入新的名字',
                    labelText: '名字',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: _borderRadius),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    newPhone = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入新的联系方式',
                    labelText: '联系方式',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: _borderRadius),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    newClass = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入班级',
                    labelText: '班级',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: _borderRadius),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    newEmail = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入用户邮箱',
                    labelText: '用户邮箱',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: _borderRadius),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      child: Text("修改信息", style: _normalFont),
                      color: Colors.blue,
                      disabledColor: Colors.black12,
                      textColor: Colors.white,
                      disabledTextColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onPressed: _editButtonPressed(
                          Constant.userConfigInfo.authtoken)),
                )
              ],
            ),
          ),
        ));
  }
}
