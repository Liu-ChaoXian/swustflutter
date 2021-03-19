import 'package:flutter/material.dart';


class AddExperiment extends StatefulWidget {
  @override
  _AddExperimentState createState() => _AddExperimentState();
}

class _AddExperimentState extends State<AddExperiment> {
  ///实验室名称
  String experimentName;
  ///实验室地址
  String experimentAddress;
  ///实验室负责人
  String director;
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

    if (experimentName.isNotEmpty && experimentAddress.isNotEmpty && director.isNotEmpty
      && detailInfo.isNotEmpty && achievement.isNotEmpty && time.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }
  _getLoginButtonPressed() {
    if (!_isEnableLogin) return null;

    return (){
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建实验室'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: (){
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
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                onChanged: (text) {
                  director = text;
                  _checkUserInput();
                },
                style: _normalFont,
                decoration: InputDecoration(
                  hintText: '请输入实验室老师',
                  labelText: '实验室老师',
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  contentPadding: EdgeInsets.only(left: 8),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                ),
              ),
              SizedBox(height: 10,),
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
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                ),
              ),
              SizedBox(height: 10,),
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
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                ),
              ),
              SizedBox(height: 10,),
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
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                ),
              ),
              SizedBox(height: 10,),
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
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
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
                  onPressed: _getLoginButtonPressed()
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

