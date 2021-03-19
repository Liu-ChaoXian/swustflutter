import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassWord extends StatefulWidget{

  @override
  createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {


  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);

  String _accountText = '';
  String _pwdText = '';
  String _pwdFixText = '';
  String _verificationCode = '';
  bool _isEnableFix = false;
  bool _obscureText = true;
  bool _obscureFixText = true;
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();
  var _pwdFixController = TextEditingController();
  var _verificationCodeController = TextEditingController();

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     */
    if (_accountText.isNotEmpty && _pwdText.isNotEmpty && _pwdFixText.isNotEmpty
        && _verificationCode.isNotEmpty) {
      if (_isEnableFix) return;
    } else {
      if (!_isEnableFix) return;
    }

    setState(() {
      _isEnableFix = !_isEnableFix;
    });
  }


  Widget _buildAccountEditTextField() {  ///手机号输入框
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: _accountController,
        onChanged: (text) {
          _accountText = text;
          _checkUserInput();
        },
        style: _normalFont,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: '请输入手机号',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: _borderRadius),
        ),
      ),
    );
  }

  Widget _buildPwdEditTextField() {  /// 输入新的登录密码
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: _pwdController,
        onChanged: (text) {
          _pwdText = text;
          _checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: '请输入新的登录密码',
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

  Widget _buildFixPwdEditTextField() {  /// 确认登录密码
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: _pwdFixController,
        onChanged: (text) {
          _pwdFixText = text;
          _checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureFixText, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: '确认新的登录密码',
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureFixText = !_obscureFixText),
              icon: Image.asset(
                _obscureFixText ? 'assets/closeEye.png' : 'assets/openEye.png',
                width: 20,
                height: 20,
              ),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            )),
      ),
    );
  }

  String buttonValue = '获取验证码';
  int deadline = 0;
  getVerificationCode() {  ///这里有bug
//      if(deadline == 0){
//        deadline = 60;
//
//      }
      return(){};
//      setState(() {
//        print(deadline);
//        buttonValue = deadline.toString();
//      });
      return null;
    }


  Widget _buildVerificationCode() {  /// 验证码按钮
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _verificationCodeController,
              onChanged: (text) {
                _verificationCode = text;
                _checkUserInput();
              },
              style: _normalFont,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.verified_user), /// 验证码图标
                  hintText: '验证码',
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  contentPadding: EdgeInsets.only(left: 8),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none, borderRadius: _borderRadius),
                  ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              child: RaisedButton(
                child: Text('$buttonValue', style: TextStyle(fontSize: 14)),
                color: Colors.blue,
                disabledColor: Colors.black12,
                textColor: Colors.white,
                disabledTextColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: _borderRadius,
                ),
                onPressed: getVerificationCode(),
              ),
            )
          )
        ],
      ),
    );
  }

  _getLoginButtonPressed() {  /// 确认按钮事件跳转
    if (!_isEnableFix) return null;
    return () {

    };
  }

  Widget _buildFixButton() {  ///确定按钮
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        child: Text("确 定", style: _normalFont),
        color: Colors.blue,
        disabledColor: Colors.black12,
        textColor: Colors.white,
        disabledTextColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        onPressed: _getLoginButtonPressed(),
      ),
    );
  }


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
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _buildAccountEditTextField(),
            _buildPwdEditTextField(),
            _buildFixPwdEditTextField(),
            _buildVerificationCode(),
            _buildFixButton()
          ],
        ),
      ),
    );
  }
}