import 'package:flutter/material.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:swustflutter/common/SwustApi.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:swustflutter/pages/mine/personal_center.dart';
import 'package:swustflutter/main.dart';

class EditExperiment extends StatefulWidget {
  @override
  _EditExperimentState createState() => _EditExperimentState();
}

class _EditExperimentState extends State<EditExperiment> {
  ///实验室名称
  String experimentName;

  ///实验室联系方式
  String labContact;

  ///实验室简介
  String detailInfo;

  /// 实验室地址
  String newLabAddr;

  /// 实验室成果
  String newLabHonor;

  /// 招新时间
  String newLabRecruitTime;

  bool _isEnableLogin = false;
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  void _checkUserInput() {
    if (experimentName.isNotEmpty &&
        labContact.isNotEmpty &&
        detailInfo.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  Map<String, dynamic> paras = {};
  _editExperiment() async {
    return await SwustApi().Post('修改实验室', '/lab/alter', json: paras);
  }

  _editButtonPressed(String token) {
    if (!_isEnableLogin) return null;

    return () {
      paras['newName'] = experimentName;
      paras['labId'] = Constant.userInfo.labs[0];
      paras['newIntro'] = detailInfo;
      paras['newContact'] = labContact;
      paras['newLabAddr'] = newLabAddr;
      paras['newLabHonor'] = newLabHonor;
      paras['newLabRecruitTime'] = newLabRecruitTime;

      _editExperiment().then((value) {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => route == null);
          Constant.useFlush(value['msg'], context);
        });
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('修改信息'),
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
                    experimentName = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入实验室名称',
                    labelText: '实验室名称',
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
                    labContact = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入联系方式',
                    labelText: '实验室联系方式',
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
                    detailInfo = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: '请输入实验室简介',
                    labelText: '实验室简介',
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
                    newLabAddr = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '请输入实验室地址',
                    labelText: '实验室地址',
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
                    newLabHonor = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: '请输入实验室成果',
                    labelText: '实验室成果',
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
                    newLabRecruitTime = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '请输入实验室招新',
                    labelText: '实验室招新',
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
                ),
              ],
            ),
          ),
        ));
  }
}
