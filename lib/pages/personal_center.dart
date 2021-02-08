import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/pages/login_page.dart';

class PersonalCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  final _normalFont = const TextStyle(fontSize: 18.0);


  String _userAccount = 'user1';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _prefs.then((prefs) => setState(
        () => _userAccount = prefs.getString(Constant.userAccount) ?? 'user1'));
  }

  Widget _buildButton() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.track_changes),
        title: Text('切换账号'),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              LoginPage()));
        },
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
            Row(
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
                          Text(
                            _userAccount,
                            style: _normalFont,
                          ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            _buildButton(),
          ],
        ),
      ),
    );
  }
}
