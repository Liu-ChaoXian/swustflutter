import 'package:swustflutter/model/user_info.dart';

import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  ///实验室列表

  List users;

  UserListWidget(
    this.users,
  );

  @override
  Widget build(BuildContext context) => _buildFilesWidget();

  Widget _buildFilesWidget() => this.users.length == 0
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
          itemCount: this.users.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildUserItem(this.users[index]);
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
          leading: Icon(Icons.person),
          title: Row(
            children: <Widget>[
              Column(
                children: [
                  Text("学号:      " + userInfo['memberId']),
                  Text("姓名:      " + userInfo['memberName']),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
