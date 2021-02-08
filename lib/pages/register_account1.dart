import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterAccount extends StatefulWidget {
  @override
  createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);
  final _formKey = GlobalKey<FormState>();
  DateTime _lastPressedAt;

  String _accountText = '';
  String _pwdText = '';
  bool _isEnableLogin = false;
  bool _obscureText = true;
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();

  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.face,
    },
    {
      "title": "google",
      "icon": Icons.account_box,
    },
    {
      "title": "twitter",
      "icon": Icons.account_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                  buildEmailTextField(),
                  SizedBox(height: 30.0),
                  buildPasswordTextField(context),
                  buildForgetPasswordText(context),
                  SizedBox(height: 60.0),
                  buildRegisterButton(context),
                  SizedBox(height: 30.0),
                  buildOtherRegisterText(),
                  buildOtherMethod(context),
                ],
              ))),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO : 第三方登录方法
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("${item['title']}登录"),
                          action: new SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          ),
                        ));
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildOtherRegisterText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              print('username:$_accountText , password:$_pwdText');
              // _register();
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onSaved: (String value) => _pwdText = value,
      obscureText: _isObscure,
      validator: (String value) {
        return value.trim().length >= 6 ? null : "密码不能小于6位";
      },
      decoration: InputDecoration(
          labelText: '密码',
          hintText: "你的密码",
          icon: Icon(Icons.lock),
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

  TextFormField buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      validator: (String value) {
        return value.trim().length > 0 ? null : "用户名不能为空";
      },
      decoration: InputDecoration(
        labelText: '用户名',
        hintText: "用户名或邮箱",
        icon: Icon(Icons.person),
      ),
      onSaved: (String value) => _accountText = value,
    );
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
        '注册',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
