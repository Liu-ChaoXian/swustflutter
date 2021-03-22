import 'package:flutter/cupertino.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/pages/login/forget_password.dart';
import 'package:swustflutter/pages/login/login_page.dart';
import 'package:swustflutter/pages/mine/change_pwd.dart';
import 'package:swustflutter/pages/mine/judge_experiment.dart';
import 'package:swustflutter/pages/mine/my_experiment.dart';
import 'user_page.dart';
import 'add_experiment.dart';
import '../../model/user_info.dart';
import '../../client/swust_api_client.dart';
import 'package:flushbar/flushbar.dart';

class PersonalCenter extends StatefulWidget {
  SwustAPIClient apiClient = new SwustAPIClient();
  @override
  State<StatefulWidget> createState() => _PersonalCenterState();
}

enum GetState { loading, loaded, fail }

class _PersonalCenterState extends State<PersonalCenter> {
  GetState _state = GetState.loading;
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titlrFont =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  final List<String> level = ['普通用户', '实验室负责人', '系统管理员'];

  String _userAccount = 'user1';
  int userLevel = 1;
  String avatarUrl = 'assets/user-head.jpg';
  SwustAPIClient apiClient = new SwustAPIClient();

  /// 获取用户个人信息
  _getInfo(String token) async {
    Map<String, dynamic> value = await apiClient.getUserInfo(token);
    print(value['userName']);
    return value;
  }

  @override
  void initState() {
    super.initState();
    _getInfo(Constant.userConfigInfo.authtoken).then((value) {
      setState(() {
//        print(value);
        Constant.userInfo = UserInfo.fromJson(value);
        avatarUrl = Constant.baseUrl + Constant.userInfo.userAvatarUrl;
        _userAccount = Constant.userInfo.userName;
        _state = GetState.loaded;
        userLevel = Constant.userConfigInfo.userType;
//        print('用户头像' + avatarUrl);
//        print('用户等级：'+ userLevel.toString());
      });
    });
  }

  /// 注销账号
  Future<Map<String, dynamic>> _logoffAccount(String token) async {
    return widget.apiClient.logoffAccount(token);
  }

  _logoff(String token) {
    return () {
      setState(() {
//        _logoffAccount(token).then((value){
//          if(value['msg'] == '账户注销成功'){
//
//          }
//        });
        /// 返回根
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route == null);
        Constant.useFlush('注销成功！', context);
      });
    };
  }

  /// 切换账号
  Widget _buildChange() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: ListTile(
        leading: Icon(Icons.cached, color: Color.fromRGBO(244, 67, 54, 1)),
        title: Text(
          '切换账号',
          style: _normalFont,
        ),
        trailing:
            Icon(Icons.navigate_next, color: Color.fromRGBO(33, 150, 243, 1)),
        onTap: _logoff(Constant.userConfigInfo.authtoken),
      ),
    );
  }

  /// 我的实验室
  Widget _buildMyExperiment() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: ListTile(
        leading: Icon(Icons.info, color: Color.fromRGBO(33, 150, 243, 1)),
        title: Text('我的实验室', style: _normalFont),
        trailing:
            Icon(Icons.navigate_next, color: Color.fromRGBO(33, 150, 243, 1)),
        onTap: () {
          /// 设置跳转到我的实验室界面
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyExperiment()));
        },
      ),
    );
  }

  _addExperiment() {
    return () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddExperiment()));
    };
  }

  /// 新增实验室
  Widget _buildAddExperiment() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: ListTile(
        leading: Icon(Icons.add, color: Color.fromRGBO(233, 30, 99, 1)),
        title: Text('新建实验室', style: _normalFont),
        trailing:
            Icon(Icons.navigate_next, color: Color.fromRGBO(33, 150, 243, 1)),

        /// 设置跳转到新增实验室界面
        onTap: _addExperiment(),
      ),
    );
  }

  /// 审核实验室
  Widget _buildCheckExperiment() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: ListTile(
        leading:
            Icon(Icons.remove_red_eye, color: Color.fromRGBO(83, 109, 254, 1)),
        title: Text('审核实验室', style: _normalFont),
        trailing:
            Icon(Icons.navigate_next, color: Color.fromRGBO(33, 150, 243, 1)),
        onTap: () {
          /// 设置跳转到审核实验室界面
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => JudgeExperiment()));
        },
      ),
    );
  }

  ///  修改密码
  Widget _buildUserPwd() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: ListTile(
        leading: Icon(Icons.security, color: Color.fromRGBO(76, 175, 80, 1)),
        title: Text('修改密码', style: _normalFont),
        trailing:
            Icon(Icons.navigate_next, color: Color.fromRGBO(33, 150, 243, 1)),
        onTap: () {
          /// 设置跳转到修改密码界面
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangePwdPage()));
        },
      ),
    );
  }

  Widget _buildContent(int userLevel) {
    switch (userLevel) {
      case 1:
        return Column(
          children: <Widget>[
            _buildMyExperiment(),
            SizedBox(height: 10),
            _buildUserPwd(),
            SizedBox(height: 10),
            _buildChange(),
          ],
        );
        break;
      case 0:
        return Column(
          children: <Widget>[
            _buildMyExperiment(),
            SizedBox(
              height: 10,
            ),
            _buildAddExperiment(),
            SizedBox(height: 10),
            _buildUserPwd(),
            SizedBox(
              height: 10,
            ),
            _buildChange(),
          ],
        );
        break;
      case 2:
        return Column(
          children: <Widget>[
            _buildMyExperiment(),
            SizedBox(
              height: 10,
            ),
            _buildAddExperiment(),
            SizedBox(
              height: 10,
            ),
            _buildCheckExperiment(),
            SizedBox(height: 10),
            _buildUserPwd(),
            SizedBox(
              height: 10,
            ),
            _buildChange(),
          ],
        );
        break;
      default:
        break;
    }
  }

  /// 跳转到个人详细信息界面
  _getUserInfo() {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPage(Constant.userInfo)));
    };
  }

  Widget _buildInfo(String _userAccount, int userLevel) {
    return InkWell(
      onTap: _getUserInfo(),
      child: Container(
        height: 100,
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.network('$avatarUrl',
                  width: 64, height: 64, fit: BoxFit.cover),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    _userAccount,
                    style: _titlrFont,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    level[userLevel],
                    style: _normalFont,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidget() {
    switch (_state) {
      case GetState.loading:
        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
              Text('正在加载')
            ],
          ),
        );
      case GetState.loaded:
        return Column(
          children: <Widget>[
            _buildInfo(_userAccount, userLevel),
            SizedBox(height: 60),
            _buildContent(userLevel),
          ],
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 40),
          child: buildWidget()),
    );
  }
}
