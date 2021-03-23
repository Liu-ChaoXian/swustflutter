import 'package:swustflutter/common/SwustApi.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/pages/detail_info.dart';
import 'package:swustflutter/pages/mine/sign_page.dart';
import 'package:swustflutter/pages/mine/userlist_page.dart';
import '../../client/swust_api_client.dart';
import 'package:swustflutter/config/constant.dart';
import '../../config/constant.dart';
import '../../model/experiment_info.dart';
import 'add_experiment.dart';
import '../../model/user_info.dart';

class MyExperiment extends StatefulWidget {
  @override
  _MyExperimentState createState() => _MyExperimentState();
}

enum GetState { loading, loaded, fail }

class _MyExperimentState extends State<MyExperiment> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titlrFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  /// 页面状态
  GetState _state = GetState.loading;
  SwustAPIClient apiClient = new SwustAPIClient();
  /// 实验室信息对象
  ExperimentInfo _experimentInfo;

  /// 获取实验室详细信息
  getDetailInfo() async{
    return await apiClient.getDetailInfo(Constant.userInfo.labs[0], Constant.userConfigInfo.authtoken);
  }
  @override
  void initState() {
    super.initState();
    getDetailInfo().then((value){
      setState(() {
        _experimentInfo = ExperimentInfo.fromJsonAll(value);
        _state = GetState.loaded;
      });
    });
  }

  _getExperimentInfo() {
    return () {
      Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailInfo(
                    experimentInfo: _experimentInfo,)));};
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
              child: Image.network(Constant.baseUrl + _experimentInfo.labAvatarUrl,
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
                    _experimentInfo.experimentName,
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
      case 1:
        return Column(
          children: <Widget>[
            SizedBox(height: 10,),
            _buildItem(title: '发起签到',
                icon: Icon(Icons.location_on, color: Colors.blue,),
                method: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignPage()))
                    }),
            SizedBox(height: 10,),
            _buildItem(title: '修改实验室信息',
                icon: Icon(Icons.edit, color: Colors.indigoAccent,),
                method: () => {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddExperiment()))}),
            SizedBox(height: 10,),
            _buildItem(title: '实验室成员',
                icon: Icon(Icons.people, color: Colors.yellow,),
                method: () => {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UserListPage()))
                    }),
            SizedBox(height: 10,),
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

  Widget buildWidget() {
    switch (_state) {
      case GetState.loading:
        return Center(
          heightFactor: 5,
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(strokeWidth: 4.0),
              Text('正在搜索')
            ],
          ),
        );
      case GetState.loaded:
        return buildInnerWidget();
      default:
        break;
    }
  }

  Widget buildInnerWidget() {
    return Constant.userInfo.labs.length == 0 ?
      Center(
        heightFactor: 5,
        child: Column(
          children: [
            SizedBox(height: 200,),
            Icon(Icons.hourglass_empty),
            Text('您还未加入实验室！',style: _normalFont,)
          ],
        ),
      ) : Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        children: <Widget>[
          _buildInfo(),
          SizedBox(height: 20),
          _buildContent(Constant.userInfo.userType),
        ],
      ),
    );
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
      body: buildWidget(),
    );
  }

  dynamic a() async {
    Map<String, dynamic> r = await SwustApi().Get('info', "/user/info");
    print(r);
  }
}
