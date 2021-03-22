import 'package:flutter/material.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flushbar/flushbar.dart';
import '../login/login_page.dart';


class ChangePwdPage extends StatefulWidget {
  @override
  _ChangePwdPageState createState() => _ChangePwdPageState();
}

class _ChangePwdPageState extends State<ChangePwdPage> {

  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  SwustAPIClient apiClient = new SwustAPIClient();
  Map paras = {};

  String oldPwd;
  String newPwd1;
  String newPwd2;
  bool _isEnableFix = false;
  bool _oldObscureText = true;
  bool _obscureText = true;
  bool _obscureFixText = true;

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     */
    if (oldPwd.isNotEmpty && newPwd1.isNotEmpty && newPwd2.isNotEmpty) {
      if (_isEnableFix) return;
    } else {
      if (!_isEnableFix) return;
    }

    setState(() {
      _isEnableFix = !_isEnableFix;
    });
  }


  Widget _buildOldPwdEditTextField() {  ///旧密码输入框
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          oldPwd = text;
          _checkUserInput();
        },
        style: _normalFont,
        obscureText: _oldObscureText, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: '请输入旧密码',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: _borderRadius),
          suffixIcon: IconButton(
            onPressed: () => setState(() => _oldObscureText = !_oldObscureText),
            icon: Image.asset(
              _oldObscureText ? 'assets/closeEye.png' : 'assets/openEye.png',
              width: 20,
              height: 20,
            ),
            splashColor: Colors.transparent, // 去掉点击阴影效果
            highlightColor: Colors.transparent, // 去掉点击阴影效果
          )
        ),
      ),
    );
  }

  Widget _buildPwdEditTextField() {  /// 输入新的登录密码
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          newPwd1 = text;
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

  Widget _buildFixPwdEditTextField() {  /// 确认新的登录密码
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          newPwd2 = text;
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

  String _checkInputText(String _pwdText1, String _pwdText2) {
    /// 两次输入的密码必须一致
    if(_pwdText1 != _pwdText2){
      return '两次输入的密码不一致！';
    }else if(_pwdText1.length<6 || _pwdText1.length>16){ /// 密码长度限制
      return '输入密码的长度应是6至16位！';
    }else{
      return '';
    }
  }

  Future<Map<String, dynamic>> _changePwd(Map paras, String token) async{
    return await apiClient.changePwd(paras,token);
  }

  _getLoginButtonPressed() {  /// 确认按钮事件跳转
    if (!_isEnableFix) return null;
    return () {
      setState(() {
        paras['newPwd'] = newPwd1;
        String showMsg = _checkInputText(newPwd1, newPwd2);
        if(showMsg == ''){
          print('token' + Constant.userConfigInfo.authtoken);
          _changePwd(paras, Constant.userConfigInfo.authtoken).then((msg){
            if(msg['msg'] == '密码修改成功！') {  /// 跳转
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => route == null);
            }
            Constant.useFlush(msg['msg'], context);
          });
        }else{
          Constant.useFlush(showMsg, context);
        }
      });
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
            _buildOldPwdEditTextField(),
            _buildPwdEditTextField(),
            _buildFixPwdEditTextField(),
            _buildFixButton()
          ],
        ),
      ),
    );
  }
}
