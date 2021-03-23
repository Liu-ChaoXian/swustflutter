import 'package:swustflutter/model/user_info.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/config/constant.dart';

class ApplyListWidget extends StatefulWidget {
  List<dynamic> users;
  ApplyListWidget(this.users);
  @override
  _ApplyListWidgetState createState() => _ApplyListWidgetState();
}

class _ApplyListWidgetState extends State<ApplyListWidget> {

  final _normalFont = const TextStyle(fontSize: 18.0);
  SwustAPIClient apiClient = new SwustAPIClient();
  Map paras = {};

  Future<Map<String,dynamic>> getPassJudge(Map paras) async {
    print('getPassJudge');
    return await apiClient.judgeApplyUser(
        paras, Constant.userConfigInfo.authtoken);
  }

  Future<Map<String,dynamic>> getFailJudge(Map paras) async {
    return await apiClient.judgeApplyUser(
        paras, Constant.userConfigInfo.authtoken);
  }

  passJudge(String userAccount) {
    print(userAccount);
    paras['userAccount'] = userAccount;
    paras['result'] = 'pass';
    getPassJudge(paras).then((value) {
      print(value);
      if (value['msg'] == '审核通过') {
        setState(() {
          Navigator.of(context).pop();
          Constant.useFlush(value['msg'], context);
        });
      }
    });
  }

  failJudge(String userAccount) {
    paras['userAccount'] = userAccount;
    paras['result'] = 'fail';
    getFailJudge(paras).then((value) {
      print(value);
      if (value['msg'] == '审核不通过') {
        setState(() {
          Navigator.of(context).pop();
          Constant.useFlush(value['msg'], context);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) => _buildListWidget();

  Widget _buildListWidget() => widget.users.length == 0
      ? Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 200),
        Icon(
          Icons.hourglass_empty,
          size: 40,
        ),
        Text('未找到相关信息', style: _normalFont,)
      ],
    ),
  )
      : ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: widget.users.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildUserItem(widget.users[index]);
    },
  );

  Widget _buildUserItem(Map userInfo) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Icon(Icons.person, size: 50,),
          title: Row(
            children: <Widget>[
              Column(
                children: [
                  Text("学号: " + userInfo['userAccount'], style: _normalFont),
                  Text("姓名: " + userInfo['userName'], style: _normalFont),
                  Divider(),
                ],
              ),
              Container(width: 10,),
              Column(
                children: [
                  RaisedButton(
                    child: Text('同意'),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      passJudge(userInfo['userAccount']);
                    },
                  ),
//                  SizedBox(height: 5),
                  RaisedButton(
                    child: Text('拒绝'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      failJudge(userInfo['userAccount']);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

