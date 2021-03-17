import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterAccount extends StatefulWidget{
  @override
  createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {

  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);

  String _accountText = '';
  String _pwdText1 = '';
  String _pwdText2 = '';
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  var _accountController = TextEditingController();
  var _pwdController1 = TextEditingController();
  var _pwdController2 = TextEditingController();


  Widget _buildAccountEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: TextField(
        controller: _accountController,
        onChanged: (text) {
          _accountText = text;
          //_checkUserInput();
        },
        style: _normalFont,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: tips,
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: _borderRadius),
        ),
      ),
    );
  }

  Widget _buildPwdEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: _pwdController1,
        onChanged: (text) {
          _pwdText1 = text;
          //_checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText1, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: tips,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText1 = !_obscureText1),
              icon: Image.asset(
                _obscureText1 ? 'assets/closeEye.png' : 'assets/openEye.png',
                width: 20,
                height: 20,
              ),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            )),
      ),
    );
  }

  Widget _buildAgainPwdEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: _pwdController2,
        onChanged: (text) {
          _pwdText2 = text;
          //_checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText2, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: tips,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText2 = !_obscureText2),
              icon: Image.asset(
                _obscureText2 ? 'assets/closeEye.png' : 'assets/openEye.png',
                width: 20,
                height: 20,
              ),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            )),
      ),
    );
  }

  Widget _buildRegisterButton() {  ///注册按钮
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        child: Text("注 册", style: _normalFont),
        color: Colors.blue,
        disabledColor: Colors.black12,
        textColor: Colors.white,
        disabledTextColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        onPressed: () {

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册账户'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: <Widget>[
            _buildAccountEditTextField('请输入手机号码'),
            _buildPwdEditTextField('请设置登录密码'),
            _buildAgainPwdEditTextField('确认密码'),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }
}