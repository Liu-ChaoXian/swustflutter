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
