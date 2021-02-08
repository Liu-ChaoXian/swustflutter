import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassWord extends StatefulWidget{

  @override
  createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('找回密码'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('找回密码！！！'),
          ],
        ),
      ),
    );
  }
}