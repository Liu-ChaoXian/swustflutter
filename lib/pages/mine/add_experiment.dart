import 'package:flutter/material.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:swustflutter/pages/mine/personal_center.dart';
import 'package:swustflutter/main.dart';

class AddExperiment extends StatefulWidget {
  @override
  _AddExperimentState createState() => _AddExperimentState();
}

class _AddExperimentState extends State<AddExperiment> {
  ///实验室名称
  String experimentName;

  ///实验室地址
  String experimentAddress;

  ///实验室联系方式
  String labContact;

  ///实验室简介
  String detailInfo;

  ///图片信息  可以保存多张图片
  List<String> imageLink;

  ///实验室成果
  String achievement;

  ///实验室招新时间
  String time;
  bool _isEnableLogin = false;
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  void _checkUserInput() {
    if (experimentName.isNotEmpty &&
        experimentAddress.isNotEmpty &&
        labContact.isNotEmpty &&
        detailInfo.isNotEmpty &&
        achievement.isNotEmpty &&
        time.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  Map<String, dynamic> paras = {};
  SwustAPIClient apiClient = new SwustAPIClient();

  Future<Map<String, dynamic>> _createExperiment(
      Map paras, String token) async {
    return await apiClient.createExperiment(paras, token);
  }

  _createButtonPressed(String token) {
    if (!_isEnableLogin) return null;

    return () {
      paras['labName'] = experimentName;
      paras['applicantId'] = Constant.userInfo.userAccount;
      paras['labIntro'] = detailInfo;
      paras['labContact'] = labContact;
      paras['labAddr'] = experimentAddress;
      paras['labHonor'] = achievement;
      paras['labRecruitTime'] = time;
      _createExperiment(paras, token).then((value) {
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
          title: Text('新建实验室'),
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
                    experimentAddress = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
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
                    time = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  decoration: InputDecoration(
                    hintText: '请输入招新时间',
                    labelText: '招新时间',
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
                    achievement = text;
                    _checkUserInput();
                  },
                  style: _normalFont,
                  maxLines: 3,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      child: Text("新 建 实 验 室", style: _normalFont),
                      color: Colors.blue,
                      disabledColor: Colors.black12,
                      textColor: Colors.white,
                      disabledTextColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onPressed: _createButtonPressed(
                          Constant.userConfigInfo.authtoken)),
                )
              ],
            ),
          ),
        ));
  }
}
