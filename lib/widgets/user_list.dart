import 'package:swustflutter/common/SwustApi.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/model/user_info.dart';

import 'package:flutter/material.dart';

class UserListWidget extends StatefulWidget {
  List users;
  UserListWidget({Key key, @required this.users}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserListState();
}

class _UserListState extends State<UserListWidget> {
  ///实验室列表

  @override
  Widget build(BuildContext context) => _buildFilesWidget();

  Widget _buildFilesWidget() => widget.users.length == 0
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200),
              Icon(
                Icons.hourglass_empty,
                size: 40,
              ),
              Text('未找到相关信息')
            ],
          ),
        )
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.users.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildUserItem(widget.users[index], context);
          },
        );

  Widget _buildUserItem(Map userInfo, BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Icon(Icons.person),
          trailing: ElevatedButton(
              child: Text('删除'),
              onPressed: () async {
                Map<String, dynamic> params = {
                  "memberId": userInfo['memberId']
                };
                Map<String, dynamic> value = await SwustApi()
                    .Post('删除实验室成员', '/lab/delete/member', json: params);
                Constant.useFlush("${value['msg']}+,请重新进入该页面", context);
                // if(value['msg']==)
              }),
          title: Row(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("学号:      " + userInfo['memberId']),
                      Text("姓名:      " + userInfo['memberName']),
                      Divider(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
