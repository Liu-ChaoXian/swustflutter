import 'package:flutter/material.dart';
import '../model/user_info.dart';

class UserPage extends StatelessWidget {
  UserInfo _userInfo;
  UserPage(this._userInfo);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titleFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人详情'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  child:  Column(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('用户昵称：', style: _titleFont),
                                      Text('${_userInfo.userName}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('用户头像：', style: _titleFont),
                                        ClipOval(
                                          child: Image.asset(_userInfo.imageLink,
                                              width: 64, height: 64, fit: BoxFit.cover),
                                        ),
                                      ],
                                  ),
                                  ),
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('真实姓名：', style: _titleFont),
                                      Text('${_userInfo.realName}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('学生学号：', style: _titleFont),
                                      Text('${_userInfo.studyID}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('所在班级：', style: _titleFont),
                                      Text('${_userInfo.classInfo}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('所在专业：', style: _titleFont),
                                      Text('${_userInfo.major}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('用户邮箱：', style: _titleFont),
                                      Text('${_userInfo.email}', style: _normalFont),
                                    ],
                                  )
                              ),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text('手机号码：', style: _titleFont),
                                      Text('${_userInfo.phone}', style: _normalFont),
                                    ],
                                  )
                              ),
                            ],
                          )
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
