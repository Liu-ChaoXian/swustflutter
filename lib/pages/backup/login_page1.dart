import 'package:swustflutter/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/pages/login/forget_password.dart';
import 'package:swustflutter/pages/backup/register_account1.dart';

import '../../config/constant.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _biggerFont =
      const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  final _formKey = GlobalKey<FormState>();

  String _accountText = '';
  String _pwdText = '';
  bool _isEnableLogin = false;
  bool _obscureText = true;
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();
  bool _isObscure = true;
  Color _eyeColor;

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     * 3、请思考如何解决当允许登录状态改变时，不重绘整个LoginPage，而是局部发生重绘优化性能，
     *    在后期复杂场景下有助于性能提升。
     */
    if (_accountText.isNotEmpty && _pwdText.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  _getLoginButtonPressed() {
    if (!_isEnableLogin) return null;

    // return () async {
    //   final SharedPreferences prefs = await _prefs;
    //   prefs.setString(Constant.userAccount, _accountText);
    //   prefs.setString(Constant.userPassword, _pwdText);

    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MyHomePage()));
    // };
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    _prefs.then((prefs) {
      _accountText = prefs.getString(Constant.userAccount) ?? '';
      _accountController.text = _accountText;
      _pwdText = prefs.getString(Constant.userPassword) ?? '';
      _pwdController.text = _pwdText;
      _checkUserInput();
    });
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '登录',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  // Widget _buildAccountEditTextField() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20),
  //     child: TextField(
  //       controller: _accountController,
  //       onChanged: (text) {
  //         _accountText = text;
  //         _checkUserInput();
  //       },
  //       style: _normalFont,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.person),
  //         hintText: '请输入手机号/用户名',
  //         filled: true,
  //         fillColor: Color.fromARGB(255, 240, 240, 240),
  //         contentPadding: EdgeInsets.only(left: 8),
  //         border: OutlineInputBorder(
  //             borderSide: BorderSide.none, borderRadius: _borderRadius),
  //       ),
  //     ),
  //   );
  // }
  TextFormField _buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      controller: _accountController,
      decoration: InputDecoration(
        labelText: '用户名',
      ),
      validator: (String value) {
//        var emailReg = RegExp(
//            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
//        if (!emailReg.hasMatch(value)) {
//          return '请输入正确的邮箱地址';
//        }
        if (value.isEmpty) {
          return "请输入用户名";
        }
      },
      onChanged: (text) {
        _accountText = text;
        _checkUserInput();
      },
      // onSaved: (String value) {
      //   _email = value;
      //   _nickName = value;
      // },
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterAccount(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElseText() {
    ///忘记密码和注册账户
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 90,
              child: FlatButton(
                child: Text('立即注册', textAlign: TextAlign.left),
                highlightColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterAccount(),
                      ));
                },
              )),
          Padding(padding: EdgeInsets.only(left: 120)),
          SizedBox(
              width: 100,
              child: FlatButton(
                child: Text('忘记密码?', textAlign: TextAlign.right),
                highlightColor: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new ForgetPassWord();
                  }));
                },
              )),
        ],
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      // onSaved: (String value) => _password = value,
      onChanged: (text) {
        _pwdText = text;
        _checkUserInput();
      },
      obscureText: _isObscure,
      controller: _pwdController,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: "密码",
          hintText: '请输入你的密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //   ///只有输入的内容符合要求通过才会到达此处
            //   _formKey.currentState.save();
            //   //TODO 执行登录方法
            //   _getLoginButtonPressed();
            // }
            _getLoginButtonPressed();
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    FlutterQqBridge.registerQq('101574511', '');
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0),
                _buildEmailTextField(),
                SizedBox(height: 30.0),
                buildPasswordTextField(context),
                // buildForgetPasswordText(context),
                SizedBox(height: 40.0),
                buildLoginButton(context),
                SizedBox(height: 10.0),
                // buildOtherLoginText(),
                // buildOtherMethod(context),
                // buildOtherMethod1(context),
                buildRegisterText(context),
              ],
            )));
  }
}
