import 'package:swustflutter/common/SwustApi.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/pages/detail_info.dart';
import 'package:swustflutter/pages/mine/sign_page.dart';
import 'package:swustflutter/pages/mine/userlist_page.dart';
import 'user_page.dart';
import 'add_experiment.dart';
import '../../model/user_info.dart';

class MyExperiment extends StatefulWidget {
  @override
  _MyExperimentState createState() => _MyExperimentState();
}

class _MyExperimentState extends State<MyExperiment> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titlrFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  final List<String> level = ['', '普通用户', '实验室负责人', '系统管理员'];
  ExperimentInfo _experimentInfo = ExperimentInfo(
      experimentName: '数据与知识工程数据可视化的实验室',
      experimentID: 1,
      experimentAddress: '东九A238',
      detailInfo: '软件测试实验是一个很棒的实验室！！！软件测试实验是一个很棒的实验室！！！',
      director: '潘娅',
      imageLink: [
        'assets/image1.jpg',
        'assets/image2.jpg',
        'assets/image3.gif'
      ],
      achievement: '各类比赛斩获佳绩',
      time: '每年6月份');

  String _userAccount = 'user1';
  int _nameLength;
  int userLevel = 2;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// 获取实验室详细信息
  getDetailInfo() {

  }
  @override
  void initState() {
    super.initState();

  }

  _getExperimentInfo() {
    return () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailInfo(
                    experimentInfo: _experimentInfo,
                  )));
    };
  }

  Widget _buildInfo() {
    return InkWell(
      onTap: _getExperimentInfo(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    _experimentInfo.getName(),
                    style: _titlrFont,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ListTile
  Widget _buildItem({String title, Icon icon, Function method}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //设置四周边框
//        border: new Border.all(width: 1, color: Colors.grey),
      ),
      child: ListTile(
        leading: icon,
        title: Text('$title ', style: _normalFont),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.blue,
        ),

        /// 设置跳转到新增实验室界面
        onTap: method,
      ),
    );
  }

  Widget _buildContent(int userLevel) {
    switch (userLevel) {
      case 2:
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '发起签到',
                icon: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                method: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignPage()))
                    }),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '修改实验室信息',
                icon: Icon(
                  Icons.edit,
                  color: Colors.indigoAccent,
                ),
                method: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddExperiment()))
                    }),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '实验室成员',
                icon: Icon(
                  Icons.people,
                  color: Colors.yellow,
                ),
                method: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListPage()))
                    }),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '会议记录',
                icon: Icon(
                  Icons.meeting_room,
                  color: Colors.green,
                ),
                method: () => {}),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '申请列表',
                icon: Icon(
                  Icons.list,
                  color: Colors.pink,
                ),
                method: () => {}),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '解散实验室',
                icon: Icon(
                  Icons.directions_run_sharp,
                  color: Colors.red,
                ),
                method: a),
          ],
        );
        break;
      default:
        return Column(
          children: <Widget>[
            _buildItem(
                title: '签到',
                icon: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                method: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignPage()))
                    }),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '实验室成员',
                icon: Icon(
                  Icons.people,
                  color: Colors.yellow,
                ),
                method: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListPage()))
                    }),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '会议记录',
                icon: Icon(
                  Icons.meeting_room,
                  color: Colors.green,
                ),
                method: () => {}),
            SizedBox(
              height: 10,
            ),
            _buildItem(
                title: '退出实验室',
                icon: Icon(
                  Icons.outbond,
                  color: Colors.red,
                ),
                method: () => {}),
          ],
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的实验室', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          children: <Widget>[
            _buildInfo(),
            SizedBox(height: 20),
            _buildContent(userLevel),
          ],
        ),
      ),
    );
  }

  dynamic a() async {
    Map<String, dynamic> r = await SwustApi().Get('info', "/user/info");
    print(r);
  }
}
