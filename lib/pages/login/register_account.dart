import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/pages/login/login_page.dart';
import '../../client/swust_api_client.dart';
import 'package:flushbar/flushbar.dart';
import 'package:swustflutter/config/constant.dart';

class RegisterAccount extends StatefulWidget{
  SwustAPIClient apiClient = new SwustAPIClient();
  @override
  createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {

  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  bool _isEnableLogin = false;
  String _phoneNumber = '';
  String _pwdText1 = '';
  String _pwdText2 = '';
  String _userName = '';
  String _userAccount = '';
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  var paras = Map();
//  var _accountController = TextEditingController();
//  var _pwdController1 = TextEditingController();
//  var _pwdController2 = TextEditingController();

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     */
//    print('当前状态  ${_isEnableLogin}');
    if (_phoneNumber.isNotEmpty && _pwdText1.isNotEmpty && _pwdText2.isNotEmpty
    && _userAccount.isNotEmpty && _userName.isNotEmpty) {
//      print('进入if  ${_isEnableLogin}');
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  /// 手机号
  Widget _buildPhoneNumberEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        keyboardType: TextInputType.phone,
//        controller: _accountController,
        onChanged: (text) {
          _phoneNumber = text;
          _checkUserInput();
        },
        style: _normalFont,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
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

  /// 用户名
  Widget _buildUserNameEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
//        keyboardType: TextInputType.phone,
//        controller: _accountController,
        onChanged: (text) {
          _userName = text;
          _checkUserInput();
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

  /// 密码
  Widget _buildPwdEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
//        controller: _pwdController1,
        onChanged: (text) {
          _pwdText1 = text;
          _checkUserInput();
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

  /// 确认密码
  Widget _buildAgainPwdEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
//        controller: _pwdController2,
        onChanged: (text) {
          _pwdText2 = text;
          _checkUserInput();
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

  /// 用户账号
  Widget _buildUserAccountEditTextField(String tips) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: TextField(
        keyboardType: TextInputType.phone,
//        controller: _accountController,
        onChanged: (text) {
          _userAccount = text;
          _checkUserInput();
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

  Future<String> _createNewAccount(Map paras) async{
    String msg = await widget.apiClient.createAccount(paras);
//    print('注册结果：$msg');
    return msg;
  }
  String showMsg = '';
  /// 输入
  String _checkInputText(String _pwdText1, String _pwdText2, String _phoneNumber) {
    /// 两次输入的密码必须一致
    if(_pwdText1 != _pwdText2){
      return '两次输入的密码不一致！';
    }else if(_pwdText1.length<6 || _pwdText1.length>16){ /// 密码长度限制
      return '输入密码的长度应是6至16位！';
    }else if(_phoneNumber.length != 11){
      return '手机号码输入格式有误';
    } else{
      return '';
    }
  }
  _getRegisterButtonPressed(){
    if (!_isEnableLogin) return null;
    return () {
      setState(() {
        paras['userPhone'] = _phoneNumber;
        paras['userAccount'] = _userAccount;
        paras['userName'] = _userName;
        paras['password'] = _pwdText1;
        showMsg = _checkInputText(_pwdText1, _pwdText2, _phoneNumber);
//        print(showMsg.length);
        if(showMsg == '') {
//          print(showMsg);
          _createNewAccount(paras).then((msg) {
            if(msg == '注册成功') {  /// 跳转
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => route == null);
            }
            Constant.useFlush(msg, context);
          });
//          print('执行新增函数后' + showMsg);
        }else{
          Constant.useFlush(showMsg, context);
        }
//        print('showMsg:${showMsg}');
      });
    };
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
        onPressed: _getRegisterButtonPressed(),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget>[
              _buildUserAccountEditTextField('请输入学号'),
              _buildUserNameEditTextField('请输入用户昵称'),
              _buildPhoneNumberEditTextField('请输入手机号码'),
              _buildPwdEditTextField('请设置登录密码'),
              _buildAgainPwdEditTextField('确认密码'),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}