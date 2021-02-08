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
  String _pwdText = '';
  bool _isEnableLogin = false;
  bool _obscureText = true;
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();

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
        controller: _pwdController,
        onChanged: (text) {
          _pwdText = text;
          //_checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: tips,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText = !_obscureText),
              icon: Image.asset(
                _obscureText ? 'assets/closeEye.png' : 'assets/openEye.png',
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
            _buildPwdEditTextField('确认密码'),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }
}