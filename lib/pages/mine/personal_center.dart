import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/pages/login/login_page.dart';
import 'user_page.dart';
import 'add_experiment.dart';
import '../../model/user_info.dart';

class PersonalCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titlrFont =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  final List<String> level = ['', '普通用户', '实验室负责人', '系统管理员'];
  UserInfo _userInfo = UserInfo(
      userName: '测试用户1',
      imageLink: 'assets/user-head.jpg',
      phone: '13715554223',
      realName: '江小白',
      studyID: '5120173400',
      classInfo: '计科1701',
      major: '计算机科学与技术',
      email: '363@qq.com');

  String _userAccount = 'user1';
  int _nameLength;
  int userLevel = 1;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _prefs.then((prefs) {
      setState(() {
        _userAccount = prefs.getString(Constant.userAccount) ?? 'user1';
        _nameLength = _userAccount.length;
        int temp = int.parse(_userAccount[_nameLength - 1]);
        userLevel = temp > 0 ? temp : userLevel;
      });
    });
  }

  Widget _buildChange() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //设置四周边框
//        border: new Border.all(width: 1, color: Colors.grey),
      ),
      child: ListTile(
        leading: Icon(Icons.cached),
        title: Text(
          '切换账号',
          style: _normalFont,
        ),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          /// 返回根
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => route == null);
        },
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
        //设置四周边框
//        border: new Border.all(width: 1, color: Colors.grey),
      ),
      child: ListTile(
        leading: Icon(Icons.info),
        title: Text('我的实验室', style: _normalFont),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          /// 设置跳转到我的实验室界面
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => route == null);
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
        //设置四周边框
//        border: new Border.all(width: 1, color: Colors.grey),
      ),
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text('新建实验室', style: _normalFont),
        trailing: Icon(Icons.navigate_next),

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
        //设置四周边框
//        border: new Border.all(width: 1, color: Colors.grey),
      ),
      child: ListTile(
        leading: Icon(Icons.check),
        title: Text('审核实验室', style: _normalFont),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          /// 设置跳转到审核实验室界面
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => route == null);
        },
      ),
    );
  }

  Widget _buildContent(int userLevel) {
    switch (userLevel) {
      case 2:
        return Column(
          children: <Widget>[
            _buildMyExperiment(),
            SizedBox(
              height: 10,
            ),
            _buildChange(),
          ],
        );
        break;
      case 1:
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
            _buildChange(),
          ],
        );
        break;
      case 3:
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

  _getUserInfo() {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPage(_userInfo)));
    };
  }

  Widget _buildInfo(String _userAccount, int userLevel) {
    return InkWell(
      onTap: _getUserInfo(),
      child: Container(
        height: 100,
        color: Color.fromARGB(255, 240, 240, 240),
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.asset('assets/user-head.jpg',
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

                    /// 用户昵称
                    style: _titlrFont,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    level[userLevel],

                    /// 用户等级
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 40),
        child: Column(
          children: <Widget>[
            _buildInfo(_userAccount, userLevel),
            SizedBox(height: 60),
            _buildContent(userLevel),
          ],
        ),
      ),
    );
  }
}
